class RestrictionsController < ApplicationController
	before_filter :authenticate_bar!

	def create
	#	@room = current_bar.rooms.find(params[:room])
	#	@restriction = @room.restrictions.build(params[:restriction])
	#	if @restriction.save
	#		flash[:success] = "Restriction created!"
	#		redirect_to new_room_path
	#	else
	#		render 'static_pages/home'
	#	end
	end

	def destroy
	end
end