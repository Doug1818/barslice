class ChargesController < ApplicationController
before_filter :authenticate_bar!, only: [:create, :refund]

  def create
    @reservation = Reservation.find(params[:charge][:reservation_id])
    @bar = current_bar
    @user = User.find(params[:charge][:user_id])
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    if @bar.stripe_access_token?
      token = Stripe::Token.create(
        {:customer => @user.stripe_customer_id},
        @bar.stripe_access_token)
      if charge = Stripe::Charge.create({
        :amount => params[:charge][:amount].to_i*100, #amount in cents
        :currency => "usd",
        :card => token['id']},
        @bar.stripe_access_token)
      then
        @charge = @bar.charges.build(params[:charge])
        @charge.direct_to_bar = true
        @charge.stripe_charge_id = charge['id']
        if @charge.save
          flash[:success] = "Charge made successfully."
          redirect_to bar_show_reservation_path(@reservation.id)
          UserMailer.charge_notice(@charge).deliver
        end
      end
    else
      if charge = Stripe::Charge.create(
        :amount => params[:charge][:amount].to_i*100, #amount in cents
        :currency => "usd",
        :customer => @user.stripe_customer_id)
      then
        @charge = @bar.charges.build(params[:charge])
        @charge.direct_to_bar = false
        @charge.stripe_charge_id = charge['id']
        if @charge.save
          flash[:success] = "Charge made successfully."
          redirect_to bar_show_reservation_path(@reservation.id)
          UserMailer.charge_notice(@charge).deliver
        end
      end
    end
  end

  def refund
    @charge = Charge.find(params[:id])
    @bar = current_bar
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    if @bar.stripe_access_token?
      charge = Stripe::Charge.retrieve(@charge.stripe_charge_id, @bar.stripe_access_token)
    else
      charge = Stripe::Charge.retrieve(@charge.stripe_charge_id)
    end
    if charge.refund
      @charge.refunded = true
      @charge.refunded_date = Time.now
      if @charge.save
        flash[:success] = "Charge refunded successfully."
        redirect_to root_path(tab: "tab5")
        UserMailer.refund_notice(@charge).deliver
      end
    end
  end
end