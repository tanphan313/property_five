class Product < ApplicationRecord
  belongs_to :product_type
  belongs_to :product_category
  belongs_to :price_type
  belongs_to :editor, polymorphic: true

  has_one :address

  has_many :product_images, dependent: :destroy

  with_options presence: true do
    validates :title, :product_type_id, :product_category_id, :description, :contact_mobile_phone
    validates :contact_mobile_phone, numericality: {only_integer: true}
  end
  validates :contact_phone, numericality: {only_integer: true}, allow_blank: true
  validate :ensure_cat_and_type_matched
  validate :ensure_price_type_and_type_matched
  validates :contact_email, format: {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/}, allow_blank: true

  enum house_direction: %i(unselected north north_east east south_east south south_west west north_west), _suffix: true
  enum balcony_direction: %i(unselected north north_east east south_east south south_west west north_west), _suffix: true

  delegate :name, to: :product_type, prefix: true, allow_nil: true
  delegate :name, to: :product_category, prefix: true, allow_nil: true
  delegate :name, to: :price_type, prefix: true, allow_nil: true
  delegate :email, to: :editor, prefix: true

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :product_images, allow_destroy: true

  scope :newest, -> {order(created_at: :desc)}

  def master_image
    product_images.where(master: true).first || product_images.first
  end

  private
  def ensure_cat_and_type_matched
    unless ProductCategoriesType.find_by(product_type: product_type, product_category: product_category).present?
      errors.add :base, "Product category is not correct for the given type"
    end
  end

  def ensure_price_type_and_type_matched
    unless ProductTypesPriceType.find_by(product_type: product_type, price_type: price_type).present?
      errors.add :base, "Product category is not correct for the given type"
    end
  end
end
