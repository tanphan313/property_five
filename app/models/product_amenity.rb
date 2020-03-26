class ProductAmenity < ApplicationRecord
  include OrderNameScope

  has_many :products_product_amenities, dependent: :destroy
  has_many :products, through: :products_product_amenities
end
