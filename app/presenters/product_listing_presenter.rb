class ProductListingPresenter
  include ProductPresentable

  attr_reader :product

  delegate :full_name, to: :address, prefix: true
  delegate :city_name, :district_name, :ward_name, to: :address

  def initialize product
    @product ||= product
  end
end
