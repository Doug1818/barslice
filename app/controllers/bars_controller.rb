class BarsController < ApplicationController
  def show
  	@bar = Bar.find(params[:id])
  end
end