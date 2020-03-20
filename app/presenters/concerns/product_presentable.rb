module ProductPresentable
  extend ActiveSupport::Concern

  delegate :id, :title, :price, :project, :acreage, :address, :editor_email, :editor_type, :price,
    :product_type_id, :product_category_id, :product_images, :description, :facade,
    :entrance, :house_direction, :balcony_direction, :num_floor, :num_bedroom, :num_toilet, :furniture,
    :contact_name, :contact_address, :contact_phone, :contact_mobile_phone, :contact_email, to: :product
end
