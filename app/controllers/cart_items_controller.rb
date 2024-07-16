class CartItemsController < ApplicationController
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
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])

    if @cart_item.update(cart_item_params)
      redirect_to cart_path(@cart), notice: 'Cart item was successfully updated.'
    else
      redirect_to cart_path(@cart), alert: 'Unable to update cart item.'
    end
  end

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(@cart), notice: 'Product was successfully removed from the cart.'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
