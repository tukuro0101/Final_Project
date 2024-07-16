module Admin
  class OrdersController < ApplicationController
    before_action :authenticate_admin!

    def index
      @orders = Order.all
    end

    def show
      @order = Order.find(params[:id])
    end

    def update
      @order = Order.find(params[:id])
      if @order.update(order_params)
        redirect_to admin_order_path(@order), notice: 'Order was successfully updated.'
      else
        render :edit
      end
    end

    private

    def order_params
      params.require(:order).permit(:user_id, :total_price, :status)
    end
  end
end
