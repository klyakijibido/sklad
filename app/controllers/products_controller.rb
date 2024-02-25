class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def index
    if params[:query].present?
      @products = Product.my_search_by_query(params[:query])
      # @products = Product.where("name LIKE ?", "%#{params[:query]}%")
    else
      @products = Product.first(30)
    end
  end
end
