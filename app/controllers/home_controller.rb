class HomeController < ApplicationController
  def index
    @categories = Category.all

    @products = Product.all
    if params[:category].present?
      @products = @products.where(category_id: params[:category])
    end
    if params[:search].present?
      @products = @products.where('name LIKE ?', "%#{params[:search]}%")
    end

    @products = @products.page(params[:page]).per(10)
  end
end
