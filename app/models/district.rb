class District < ApplicationRecord
  include OrderSlugScope

  belongs_to :city
  has_many :wards, dependent: :destroy
end
