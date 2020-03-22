class ProductPresenter
  include ProductPresentable

  attr_reader :product

  def initialize product
    @product ||= product
  end

  def image_urls
    return [] unless product_images.present?
    product_images.by_position.map do |img|
      {
        small: Utils.full_asset_url(img.small_url),
        medium: Utils.full_asset_url(img.medium_url)
      }
    end
  end
end
