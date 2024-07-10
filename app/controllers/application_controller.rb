class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def admin_only
    unless current_user&.admin?
      redirect_to root_path, alert: 'You are not authorized to access this section.'
    end
  end
end
