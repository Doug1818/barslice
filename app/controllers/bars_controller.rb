class BarsController < ApplicationController
  def show
  	@bar = Bar.find(params[:id])
  end

  def confirm_bar
  	@bar = Bar.find(params[:id])
  	@temp_pass = Rufus::Mnemo::from_integer(@bar.id*10000)[0..5]
  	BarMailer.identity_confirmation(@bar).deliver
  	redirect_to :back
  end
end