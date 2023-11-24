class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def index
    if params[:query].present?
      @products = Product.where("name LIKE ?", "%#{params[:query]}%")
    else
      @products = Product.first(30)
    end
  end
end
