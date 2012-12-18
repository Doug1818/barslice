class SpecialsController < ApplicationController
before_filter :authenticate_bar!, only: [:create, :edit, :update, :destroy]

  def new
  	@special = Special.new
  end

  def create
    @special = current_bar.specials.build(params[:special])
    if !params[:special][:start_date].blank?
      @special.start_date = Date.strptime(params[:special][:start_date],"%m/%d/%Y").to_date
    end
    if !params[:special][:end_date].blank?
      @special.end_date = Date.strptime(params[:special][:end_date],"%m/%d/%Y").to_date
    end
    if !params[:special][:from].blank?
      @special.from = TIMES[params[:special][:from]]
    end
    if !params[:special][:until].blank?
      @special.until = TIMES[params[:special][:until]]
  	end
    if @special.save
      flash[:success] = "Special added"
      redirect_to root_path(tab: "tab4")
    else
      render 'new'
    end
  end

  def edit
  	@special = current_bar.specials.find(params[:id])
  end

  def update
  	@special = current_bar.specials.find(params[:id])
  	if !params[:special][:start_date].blank?
    	params[:special][:start_date] = Date.strptime(params[:special][:start_date],"%m/%d/%Y").to_date
  	end
  	if !params[:special][:end_date].blank?
    	params[:special][:end_date] = Date.strptime(params[:special][:end_date],"%m/%d/%Y").to_date
    end
    if !params[:special][:from].blank?
    	params[:special][:from] = TIMES[params[:special][:from]]
    end
    if !params[:special][:until].blank?
    	params[:special][:until] = TIMES[params[:special][:until]]
    end
    if @special.update_attributes(params[:special])
      flash[:success] = "Special updated"
      redirect_to root_path(tab: "tab4")
    else
      render 'edit'
    end
  end

  def destroy
  	@special = current_bar.specials.find(params[:id])
    @special.destroy
    flash[:notice] = "Special deleted"
    redirect_to root_path(tab: "tab4")
  end

  def show
    @special = Special.find(params[:id])
  end

  def index
    redirect_to root_path(tab: "tab4")
  end
end