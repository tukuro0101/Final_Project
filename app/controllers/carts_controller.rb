class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def add_product
    product = Product.find(params[:product_id])
    @cart = current_cart
    @cart_item = @cart.add_product(product.id)

    if @cart_item.save
      redirect_to @cart, notice: 'Product added to cart.'
    else
      redirect_to products_path, alert: 'Unable to add product to cart.'
    end
  end

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
