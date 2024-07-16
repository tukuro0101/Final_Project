class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [addresses_attributes: [:street, :city, :province_id, :postal_code]])
    devise_parameter_sanitizer.permit(:account_update, keys: [addresses_attributes: [:id, :street, :city, :province_id, :postal_code]])
  end
end
