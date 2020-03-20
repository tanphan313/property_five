class ProductListingPresenter
  include ProductPresentable

  attr_reader :product

  delegate :master_image, :product_images, to: :product
  delegate :full_name, to: :address, prefix: true
  delegate :city_name, :district_name, :ward_name, to: :address

  def initialize product
    @product ||= product
  end

  def master_image_small_url
    image_url = master_image&.small_url
    Utils.full_asset_url(image_url)
  end

  def master_image_medium_url
    image_url = master_image&.medium_url
    Utils.full_asset_url(image_url)
  end
end
