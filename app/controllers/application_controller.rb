class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_cart

  def current_cart
    if session[:cart_id]
      @current_cart ||= Cart.find(session[:cart_id])
    else
      @current_cart = Cart.create(user: current_user)
      session[:cart_id] = @current_cart.id
      @current_cart
    end
  end


  private

  def admin_only
    unless current_user&.admin?
      redirect_to root_path, alert: 'You are not authorized to access this section.'
    end
  end
end
