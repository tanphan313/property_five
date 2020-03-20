class ProductTypesPriceType < ApplicationRecord
  belongs_to :product_type
  belongs_to :price_type
end
