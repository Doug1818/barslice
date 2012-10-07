class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(bar)
    if bar.claimed != true && bar.sign_in_count > 1
    	BarMailer.claimed_bar_alert(bar).deliver
		end
		root_path
  end
end
