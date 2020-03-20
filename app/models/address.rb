class Address < ApplicationRecord
  belongs_to :city
  belongs_to :district
  belongs_to :ward, optional: true
  belongs_to :product

  with_options presence: true do
    validates :city_id, :district_id, :full_name
  end
end
