class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    x = session[:return_to]
    if resource.is_a?(Bar)
	    if resource.claimed != true && resource.sign_in_count > 1
        if request.referrer.include?("/claim_bar")
          BarMailer.claimed_bar_alert(resource).deliver
          root_path
        else
          sign_out resource
          claim_bar_bar_path(resource.id)
        end
		  else
		    super
      end
  	elsif resource.is_a?(User)
  		if x != nil && x.include?("/users/sign_up.")
	  		root_path + "reservations/new." + x[x.index(".") + 1, x.length - x.index(".")]
  		else
  			super
  		end
  	else
  		super
  	end
  end

  # Exception handling (custom error messages)
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end
end
