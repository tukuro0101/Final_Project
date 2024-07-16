class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.add_cart_items(current_cart)
    @order.calculate_totals

    if @order.save
      session[:cart_id] = nil
      Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: @order.line_items_for_stripe,
        success_url: order_url(@order),
        cancel_url: cart_url(current_cart)
      )
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:address_id)
  end
end
