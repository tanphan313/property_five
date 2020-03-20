module OrderNameScope
  extend ActiveSupport::Concern

  included do
    scope :order_by_name, ->{order(name: :asc)}
  end
end
