class RemovePriceType < ActiveRecord::Migration[5.1]
  def change
    drop_table :price_types
    drop_table :product_types_price_types
    remove_column :products, :price_type_id
    change_column :products, :price, :bigint
  end
end
