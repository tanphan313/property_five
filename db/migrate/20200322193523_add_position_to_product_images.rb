class AddPositionToProductImages < ActiveRecord::Migration[5.1]
  def change
    add_column :product_images, :position, :integer
  end
end
