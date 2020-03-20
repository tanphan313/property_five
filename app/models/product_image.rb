class ProductImage < ApplicationRecord
  mount_uploader :attachment, ProductImageUploader, mount_on: :attachment_file_name

  IMAGE_STYLES = %i(small medium)

  belongs_to :product, optional: true

  IMAGE_STYLES.each do |image_style|
    define_method("#{image_style}_url") do
      attachment.url(image_style)
    end
  end
end
