class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(bar)
  	if current_bar.rooms.count == 0
  		new_room_path
	else
	  	root_path
  	end
  end
end
