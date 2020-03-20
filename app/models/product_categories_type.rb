class ProductCategoriesType < ApplicationRecord
  belongs_to :product_type
  belongs_to :product_category
end
