class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def add_product
    product = Product.find(params[:product_id])
    @cart = current_cart
    @cart_item = @cart.add_product(product.id)

    if @cart_item.persisted?
      redirect_to @cart, notice: 'Product added to cart.'
    else
      redirect_to products_path, alert: 'Unable to add product to cart.'
    end
  end

  private

  def current_cart
    if user_signed_in?
      cart = current_user.cart || current_user.create_cart
    else
      cart = Cart.find_by(id: session[:cart_id])
      if cart.nil?
        cart = Cart.create
        session[:cart_id] = cart.id
      end
    end
    cart
  end
end
