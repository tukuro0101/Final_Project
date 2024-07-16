class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_cart

  def current_cart
    if user_signed_in?
      cart = current_user.cart || current_user.create_cart
    elsif session[:cart_id]
      cart = Cart.find_by(id: session[:cart_id])
      if cart.nil?
        cart = Cart.create
        session[:cart_id] = cart.id
      end
    else
      cart = Cart.create
      session[:cart_id] = cart.id
    end
    cart
  end

  private

  def admin_only
    unless current_user&.admin?
      redirect_to root_path, alert: 'You are not authorized to access this section.'
    end
  end
end
