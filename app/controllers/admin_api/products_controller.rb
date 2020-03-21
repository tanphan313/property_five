module AdminApi
  class ProductsController < ApplicationController
    include AdminProductSearchable

    FORM_PARAMS = [:title, :product_type_id, :product_category_id, :project, :acreage, :price,
      :description, :facade, :entrance, :house_direction, :balcony_direction, :num_floor, :num_bedroom, :num_toilet,
      :furniture, :contact_name, :contact_address, :contact_phone, :contact_mobile_phone, :contact_email,
      :product_image_ids,
      address_attributes: [:id, :city_id, :district_id, :ward_id, :street, :full_name],
      product_images_attributes: [:id, :_destroy, :attachment, :description, :master]]

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
      @product = current_admin.products.build form_params
      if @product.save
        @product.reload
        render :create, status: :created
      else
        render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def update
      if product.update form_params
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
    def form_params
      @form_params ||= params.require(:product).permit(FORM_PARAMS)
    end

    def product
      @product ||= params[:id] ? Product.find(params[:id]) : current_admin.products.build
    end

    def presenter
      @presenter ||= ProductFormPresenter.new product
    end
    helper_method :presenter
  end
end
