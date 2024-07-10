
class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    # Any additional logic for the dashboard can go here
  end

  private

  def admin_only
    redirect_to root_path unless current_user.admin?
  end
end
