class ProductBusiness
  FORM_PARAMS = [:title, :product_category_id, :project, :acreage, :price,
    :description, :facade, :entrance, :house_direction, :balcony_direction, :num_floor, :num_bedroom, :num_toilet,
    :furniture, :contact_name, :contact_address, :contact_phone, :contact_mobile_phone, :contact_email,
    product_image_ids: [], product_amenity_ids: [],
    address_attributes: [:id, :city_id, :district_id, :ward_id, :street, :full_name]]

  attr_reader :product, :form_params

  def initialize product
    @product ||= product
  end

  def create params
    @form_params ||= params.require(:product).permit(FORM_PARAMS)

    product.assign_attributes form_params
    product.save
    update_image_positions
  end

  def update params
    @form_params ||= params.require(:product).permit(FORM_PARAMS)

    product.update form_params
    update_image_positions
  end

  def update_image_positions
    product.update product_images_attributes: product_images_attributes
  end

  private
  def image_ids
    @image_ids ||= form_params[:product_image_ids]
  end

  def product_images_attributes
    image_ids.map.with_index do |id, index|
      {
        id: id,
        position: index
      }
    end
  end
end
