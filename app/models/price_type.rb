class PriceType < ApplicationRecord
  include OrderNameScope

  has_many :product_types_price_types, dependent: :destroy
  has_many :product_types, through: :product_types_price_types
  has_many :products
end
