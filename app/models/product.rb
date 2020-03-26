class Product < ApplicationRecord
  belongs_to :product_type, optional: true
  belongs_to :product_category
  belongs_to :editor, polymorphic: true

  has_one :address

  has_many :product_images, dependent: :destroy
  has_many :products_product_amenities, dependent: :destroy
  has_many :product_amenities, through: :products_product_amenities

  ransacker :house_direction, formatter: proc {|v| house_directions[v]} do |parent|
    parent.table[:house_direction]
  end

  ransacker :balcony_direction, formatter: proc {|v| balcony_directions[v]} do |parent|
    parent.table[:balcony_direction]
  end

  with_options presence: true do
    validates :title, :product_category_id, :description, :contact_mobile_phone
    validates :contact_mobile_phone, numericality: {only_integer: true}
  end
  validates :contact_phone, numericality: {only_integer: true}, allow_blank: true
  validates :contact_email, format: {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/}, allow_blank: true

  enum house_direction: %i(unselected north north_east east south_east south south_west west north_west), _suffix: true
  enum balcony_direction: %i(unselected north north_east east south_east south south_west west north_west), _suffix: true

  delegate :name, to: :product_type, prefix: true, allow_nil: true
  delegate :name, to: :product_category, prefix: true, allow_nil: true
  delegate :email, to: :editor, prefix: true

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :product_images, allow_destroy: true

  scope :newest, ->{order(created_at: :desc)}
  scope :within_price_range, ->(price_range_params) do
    where(price: price_range_params)
  end

  def master_image
    product_images.by_position.first
  end
end
