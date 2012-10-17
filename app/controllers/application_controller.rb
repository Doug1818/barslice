class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    x = session[:return_to]
    if resource.is_a?(Bar)
	    if resource.claimed != true && resource.sign_in_count > 1
	    	BarMailer.claimed_bar_alert(resource).deliver
		end
		root_path
  	elsif resource.is_a?(User)
  		if x.include?("/users/sign_up.")
	  		root_path + "reservations/new." + x[x.index(".") + 1, x.length - x.index(".")]
  		else
  			super
  		end
	else
		super
	end
  end
end
