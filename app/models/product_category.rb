class ProductCategory < ApplicationRecord
  include OrderNameScope

  has_many :product_categories_types, dependent: :destroy
  has_many :product_types, through: :product_categories_types
  has_many :products
end
