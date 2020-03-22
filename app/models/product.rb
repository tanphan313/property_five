class Product < ApplicationRecord
  belongs_to :product_type
  belongs_to :product_category
  belongs_to :editor, polymorphic: true

  has_one :address

  has_many :product_images, dependent: :destroy

  ransacker :house_direction, formatter: proc {|v| house_directions[v]} do |parent|
    parent.table[:house_direction]
  end

  ransacker :balcony_direction, formatter: proc {|v| balcony_directions[v]} do |parent|
    parent.table[:balcony_direction]
  end

  before_save :reset_image_master

  with_options presence: true do
    validates :title, :product_type_id, :product_category_id, :description, :contact_mobile_phone
    validates :contact_mobile_phone, numericality: {only_integer: true}
  end
  validates :contact_phone, numericality: {only_integer: true}, allow_blank: true
  validate :ensure_cat_and_type_matched
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
    product_images.where(master: true).first || product_images.oldest.first
  end

  private
  def ensure_cat_and_type_matched
    unless ProductCategoriesType.find_by(product_type: product_type, product_category: product_category).present?
      errors.add :base, "Product category is not correct for the given type"
    end
  end

  def reset_image_master
    product_images.update master: false
  end
end
