class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:update, :destroy]

  def create
    @cart = current_cart
    @cart_item = @cart.add_product(params[:product_id])

    if @cart_item.save
      redirect_to cart_path(@cart), notice: 'Product was successfully added to the cart.'
    else
      redirect_to products_path, alert: 'Unable to add product to cart.'
    end
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_path(current_cart), notice: 'Cart item was successfully updated.'
    else
      redirect_to cart_path(current_cart), alert: 'Unable to update cart item.'
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_path(current_cart), notice: 'Product was successfully removed from the cart.'
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
