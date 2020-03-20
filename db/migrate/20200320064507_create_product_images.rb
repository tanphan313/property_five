class CreateProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_images do |t|
      t.references :product
      t.string :description
      t.boolean :master, default: false
      t.string :attachment

      t.timestamps
    end
  end
end
