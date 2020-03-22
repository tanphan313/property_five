module ProductPresentable
  extend ActiveSupport::Concern

  delegate :id, :title, :price, :project, :acreage, :address, :editor_id, :editor_email, :editor_type, :price,
    :product_type_id, :product_category_id, :product_images, :description, :facade,
    :entrance, :house_direction, :balcony_direction, :num_floor, :num_bedroom, :num_toilet, :furniture,
    :contact_name, :contact_address, :contact_phone, :contact_mobile_phone, :contact_email, :created_at, :updated_at, to: :product
  delegate :master_image, :product_images, :product_image_ids, to: :product

  def master_image_small_url
    image_url = master_image&.small_url
    Utils.full_asset_url(image_url)
  end

  def master_image_medium_url
    image_url = master_image&.medium_url
    Utils.full_asset_url(image_url)
  end
end
