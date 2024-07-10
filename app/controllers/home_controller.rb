class HomeController < ApplicationController
  def index
    @categories = Category.all

    if params[:category_ids].present?
      @products = Product.joins(:category).where(categories: { id: params[:category_ids] }).page(params[:page]).per(10)
    elsif params[:search].present? && params[:search_category_id].present?
      @products = Product.joins(:category).where('categories.id = ? AND (LOWER(products.name) LIKE ? OR LOWER(products.description) LIKE ?)', params[:search_category_id], "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").page(params[:page]).per(10)
    elsif params[:search].present?
      @products = Product.where('LOWER(name) LIKE ? OR LOWER(description) LIKE ?', "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").page(params[:page]).per(10)
    else
      @products = Product.page(params[:page]).per(10)
    end
  end
end
