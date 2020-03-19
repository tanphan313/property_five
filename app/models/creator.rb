class Creator < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  scope :newest, -> {order(created_at: :desc)}
end
