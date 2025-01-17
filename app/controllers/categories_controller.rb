class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @categories = Category.all
  end
  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page])
  end
end
