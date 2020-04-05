class Address < ApplicationRecord
  belongs_to :city
  belongs_to :district
  belongs_to :ward, optional: true
  belongs_to :product, optional: true

  with_options presence: true do
    validates :city_id, :district_id, :street
  end

  delegate :name, to: :city, prefix: true
  delegate :name, to: :district, prefix: true
  delegate :name, to: :ward, prefix: true

  def lng
    read_attribute(:lng).try(:to_d)
  end

  def lat
    read_attribute(:lat).try(:to_d)
  end
end
