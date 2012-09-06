class BarsController < ApplicationController
  def show
  	@bar = Bar.find(params[:id])
  end

  def confirm_bar
end