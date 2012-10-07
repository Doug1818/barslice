class BarsController < ApplicationController
  def show
  	@bar = Bar.find(params[:id])
  end

  def confirm_bar
  	@bar = Bar.find(params[:id])
  	BarMailer.identity_confirmation(@bar).deliver
  	BarMailer.identity_confirmation_alert(@bar).deliver
  	redirect_to :back
  end
end