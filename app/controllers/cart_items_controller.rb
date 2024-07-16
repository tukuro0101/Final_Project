class CartItemsController < ApplicationController
  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(quantity: params[:quantity])
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
  end
end
