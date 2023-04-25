class ChargesController < ApplicationController
  # potentially switch from payment to membership class, and from card to credit card
  
  before_action :authenticate_user!

  def new
  end

  def create
    stripe_card_id =
      if params[:card].present?
        CreditCardService.new(current_user.id, card_params).create_card
      else
        charge_params[:card_id]
      end
  
    Stripe::Charge.create(
      customer: current_user.customer_id,
      source:   stripe_card_id,
      amount:   @payment.price_in_cents,
      currency: 'usd'
    )
  
    if params[:card].present? && stripe_card_id
      current_user.credit_cards.create_with(card_params).find_or_create_by(stripe_id: stripe_card_id)
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to @product
    end

  private

  def card_params
    params.require(:card).permit(:number, :month, :year, :cvc)
  end
  
  def charge_params
    params.require(:charge).permit(:card_id)
  end
  
  def find_payment
    @payment = Payment.find(params[:payment_id])
  
  rescue ActiveRecord::RecordNotFound => e
    flash[:error] = 'Product not found!'
    redirect_to root_path
  end
end

