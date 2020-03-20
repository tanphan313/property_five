class Product < ApplicationRecord
  belongs_to :product_type
  belongs_to :product_category
  belongs_to :editor, polymorphic: true

  has_one :address

  has_many :product_images, dependent: :destroy

  with_options presence: true do
    validates :title, :product_type_id, :product_category_id, :description, :contact_mobile_phone
    validates :contact_mobile_phone, numericality: {only_integer: true}
  end
  validates :contact_phone, numericality: {only_integer: true}, allow_blank: true
  validates :facade, :entrance, numericality: {only_integer: true}, allow_blank: true

  enum house_direction: %i(unselected north north_east east south_east south south_west west north_west), _suffix: true
  enum bacony_direction: %i(unselected north north_east east south_east south south_west west north_west), _suffix: true
end
