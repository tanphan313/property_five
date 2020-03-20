class ProductImage < ApplicationRecord
  mount_uploader :attachment, ProductImageUploader, mount_on: :attachment_file_name

  belongs_to :product
end
