module OrderSlugScope
  extend ActiveSupport::Concern

  included do
    scope :order_by_slug, ->{order(slug: :asc)}
  end
end
