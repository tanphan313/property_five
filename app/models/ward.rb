class Ward < ApplicationRecord
  include OrderSlugScope

  belongs_to :district
end
