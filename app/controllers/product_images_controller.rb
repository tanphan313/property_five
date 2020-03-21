class ProductImagesController < ApplicationController
  FORM_PARAMS = [:attachment, :description, :master]

  def create
    product_image = ProductImage.new form_params
    if product_image.save
      product_image.reload
      render json: {id: product_image.id, small_url: product_image.small_url, medium_url: product_image.medium_url}, status: :created
    else
      render json: {errors: product_image.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    if product_image.update form_params
      product_image.reload

      render json: {id: product_image.id, small_url: product_image.small_url, medium_url: product_image.medium_url}, status: :created
    else
      render json: {errors: product_image.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    product_image.destroy
    if product_image.destroyed?
      render json: {message: "Image deleted"}, status: :created
    else
      render json: {errors: product_image.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
  def form_params
    @form_params ||= params.require(:product_image).permit(FORM_PARAMS)
  end

  def product_image
    @product_image ||= params[:id] ? ProductImage.find(params[:id]) : ProductImage.new
  end
end
