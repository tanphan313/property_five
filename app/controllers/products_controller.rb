class ProductsController < ApplicationController
  def show
    product = Product.find(params[:id])
    @presenter = ProductPresenter.new product
  end
end
