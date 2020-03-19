class City < ApplicationRecord
  include OrderSlugScope

  has_many :districts, dependent: :destroy
end
