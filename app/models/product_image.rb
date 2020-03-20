class ProductImage < ApplicationRecord
  mount_uploader :attachment, ProductImageUploader

  IMAGE_STYLES = %i(small medium)

  belongs_to :product, optional: true

  IMAGE_STYLES.each do |image_style|
    define_method("#{image_style}_url") do
      attachment_url(image_style)
    end
  end
end
