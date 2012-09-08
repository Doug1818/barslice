class BarsController < ApplicationController
  def show
  	@bar = Bar.find(params[:id])
  end

  def confirm_bar
  	BarMailer.identity_confirmation(@bar).deliver
  end
end