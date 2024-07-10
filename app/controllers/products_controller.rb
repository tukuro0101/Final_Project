class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :authenticate_user!, except: [:show]

  def show
    @product = Product.find(params[:id])
  end
end
