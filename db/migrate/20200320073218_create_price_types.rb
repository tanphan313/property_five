class CreatePriceTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :price_types do |t|
      t.references :product
      t.string :name, null: false
    end

    create_table :product_types_price_types do |t|
      t.references :product_type
      t.references :price_type
    end

    remove_column :products, :price_type, :integer, default: 0
    add_reference :products, :price_type
  end
end
