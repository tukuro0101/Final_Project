class ChargesController < ApplicationController
  def create
    @order = current_order
    @amount = (@order.total_price * 100).to_i

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )

    @order.update(status: 'paid')

    redirect_to @order, notice: 'Order was successfully paid.'
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
