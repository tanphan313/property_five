class ProductBusiness
  FORM_PARAMS = [:title, :product_type_id, :product_category_id, :project, :acreage, :price,
    :description, :facade, :entrance, :house_direction, :balcony_direction, :num_floor, :num_bedroom, :num_toilet,
    :furniture, :contact_name, :contact_address, :contact_phone, :contact_mobile_phone, :contact_email,
    product_image_ids: [],
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
    image_ids_params.each_with_index do |img_id, index|
      img = ProductImage.find(img_id)
      img.update(position: index) unless img.position == index
    end
  end

  private
  def image_ids_params
    @image_ids_params ||= form_params[:product_image_ids]
  end
end
