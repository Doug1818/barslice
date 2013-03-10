class RespoliciesController < ApplicationController
  before_filter :authenticate_bar!, only: [:create, :destroy, :edit, :update]

  def create
  	@respolicy = current_bar.build_respolicy(params[:respolicy])
  	if @respolicy.save
  		flash[:success] = "Reservation policy added"
  		redirect_to root_path(tab: "tab3")
	else
		render 'new'
	end
  end

  def edit
  	@respolicy = current_bar.respolicy(params[:id])
  end

  def update
  	@respolicy = current_bar.respolicy(params[:id])
  	if @respolicy.update_attributes(params[:respolicy])
    	flash[:success] = "Reservation policy updated"
    	redirect_to root_path(tab: "tab3")
    else
      render 'edit'
    end
  end

  def destroy
    @respolicy = current_bar.respolicy(params[:id])
    @respolicy.destroy
    flash[:notice] = "Reservation policy deleted"
    redirect_to root_path(tab: "tab3")
  end

  def index
    redirect_to root_path(tab: "tab3")
  end
end