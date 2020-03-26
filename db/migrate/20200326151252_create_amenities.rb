class CreateAmenities < ActiveRecord::Migration[5.1]
  def change
    create_table :product_amenities do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    create_table :products_product_amenities do |t|
      t.references :product
      t.references :product_amenity
    end

    add_column :products, :num_bathroom, :integer
    add_column :products, :num_parking, :integer
    add_column :products, :property_age, :float
    add_column :products, :land_acreage, :float
  end
end
