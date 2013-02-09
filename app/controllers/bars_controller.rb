class BarsController < ApplicationController
before_filter :authenticate_bar!, only: [:stripe_create]

  def show
  	@bar = Bar.find(params[:id])
  end

  def confirm_bar
  	@bar = Bar.find(params[:id])
  	BarMailer.identity_confirmation(@bar).deliver
  	BarMailer.identity_confirmation_alert(@bar).deliver
  	redirect_to :back
  end

  def add_click
  	@bar = Bar.find(params[:id])
  	@bar.update_attributes(click_count: @bar.click_count += 1)
  	redirect_to :back
  end

  def stripe_create
    current_bar.stripe_access_token = env['omniauth.auth']["credentials"]["token"]
    current_bar.stripe_publishable_key = env['omniauth.auth']["info"]["stripe_publishable_key"]
    current_bar.stripe_user_id = env['omniauth.auth']["uid"]
    current_bar.save
    redirect_to root_url, notice: "Stripe account successfully connected to BarSlice."
  end
end