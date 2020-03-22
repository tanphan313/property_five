class ProductFormPresenter
  include ProductPresentable

  attr_reader :product

  def initialize product
    @product ||= product
  end

  def address_attributes
    return {} unless address.present?
    address.attributes
  end

  def product_images_attributes
    return [] unless product_images.present?
    product_images.by_position.map do |img|
      {
        id: img.id,
        description: img.description,
        position: img.position,
        small_url: Utils.full_asset_url(img.small_url),
        medium_url: Utils.full_asset_url(img.medium_url)
      }
    end
  end
end
