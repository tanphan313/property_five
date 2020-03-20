class Creator < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :products, as: :editor

  scope :newest, -> {order(created_at: :desc)}
end
