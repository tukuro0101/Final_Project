class OrdersController < ApplicationController
  before_action :authenticate_user!

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to @order, notice: 'Order status updated.'
    else
      redirect_to @order, alert: 'Unable to update order status.'
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
