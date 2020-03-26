class ProductsProductAmenity < ApplicationRecord
  belongs_to :product
  belongs_to :product_amenity
end
