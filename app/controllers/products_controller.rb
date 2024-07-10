class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @categories = Category.all
    @products = Product.all

    if params[:category].present?
      @products = @products.where(category_id: params[:category])
    end

    @products = @products.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end
end
