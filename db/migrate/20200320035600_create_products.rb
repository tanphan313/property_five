class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :product_types do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    create_table :product_categories do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    create_table :product_categories_types do |t|
      t.references :product_type, null: false
      t.references :product_category, null: false
    end

    create_table :products do |t|
      t.references :product_type, null: false
      t.references :product_category, null: false

      t.string :title
      t.string :project
      t.float :acreage
      t.float :price
      t.integer :price_type, default: 0
      t.text :description

      t.float :facade
      t.float :entrance
      t.integer :house_direction, default: 0
      t.integer :bacony_direction, default: 0
      t.integer :num_floor
      t.integer :num_bedroom
      t.integer :num_toilet
      t.text :furniture

      t.string :contact_name
      t.string :contact_address
      t.string :contact_phone
      t.string :contact_mobile_phone
      t.string :contact_email

      t.timestamps null: false
    end

    create_table :addresses do |t|
      t.references :city, null: false
      t.references :district, null: false
      t.references :ward

      t.string :street
      t.string :full_name

      t.references :product, null: false

      t.timestamps null: false
    end
  end
end
