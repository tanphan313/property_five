module AdminApi
  class ProductsController < ApplicationController
    include AdminProductSearchable

    def index
      @products = Product.ransack(search_params).result.newest.within_price_range(price_range_params)
        .page(params[:page]).per(params[:per_page])
      @presenters = @products.map do |product|
        ProductListingPresenter.new product
      end
    end

    def show
      render :show, status: :ok
    end

    def create
      @product = current_admin.products.build
      if ProductBusiness.new(@product).create params
        @product.reload

        render :create, status: :created
      else
        render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def update
      if ProductBusiness.new(product).update params
        product.reload

        render :update, status: :created
      else
        render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def destroy
      product.destroy
      if product.destroyed?
        render json: {message: "Product deleted"}, status: :created
      else
        render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
      end
    end

    private
    def product
      @product ||= params[:id] ? Product.find(params[:id]) : current_admin.products.build
    end

    def presenter
      @presenter ||= ProductFormPresenter.new product
    end
    helper_method :presenter
  end
end
