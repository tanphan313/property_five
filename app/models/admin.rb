class Admin < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  paginates_per Settings.per_page.default

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  def confirmed?
    true
  end

  def send_confirmation_notification?
    false
  end

  def postpone_email_change?
    false
  end
end
