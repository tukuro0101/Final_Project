class CartItemsController < ApplicationController
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_path(@cart_item.cart), notice: 'Cart item updated.'
    else
      redirect_to cart_path(@cart_item.cart), alert: 'Unable to update cart item.'
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(@cart_item.cart), notice: 'Cart item removed.'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
