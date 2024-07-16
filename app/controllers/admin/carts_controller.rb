module Admin
  class CartsController < ApplicationController
    before_action :authenticate_admin!

    def index
      @carts = Cart.all
    end

    def show
      @cart = Cart.find(params[:id])
    end

    def update
      @cart = Cart.find(params[:id])
      if @cart.update(cart_params)
        redirect_to admin_cart_path(@cart), notice: 'Cart was successfully updated.'
      else
        render :edit
      end
    end

    private

    def cart_params
      params.require(:cart).permit(:user_id)
    end
  end
end
