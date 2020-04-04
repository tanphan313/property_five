class Request < ApplicationRecord
  validates :name, :phone_number, :email, :address, presence: true

  with_options presence: true do
    validates :name, :phone_number, :email, :address
    validates :phone_number, numericality: {only_integer: true}
  end
  validates :email, format: {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/}, allow_blank: true

  enum property_type: %i(house department), _suffix: true

  ransacker :property_type, formatter: proc {|v| property_types[v]} do |parent|
    parent.table[:property_type]
  end

  scope :newest, ->{order(created_at: :desc)}
end
