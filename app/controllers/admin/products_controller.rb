module Admin
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    def index
      @products = Product.all
    end

    def show
    end

    def new
      @product = Product.new
    end

    def edit
    end

    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to admin_product_path(@product), notice: 'Product was successfully created.'
      else
        render :new
      end
    end

    def update
      if @product.update(product_params)
        redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @product.destroy
      redirect_to admin_products_url, notice: 'Product was successfully destroyed.'
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image)
    end

    def admin_only
      unless current_user.admin?
        redirect_to root_path, alert: 'You are not authorized to access this section.'
      end
    end
  end
end
