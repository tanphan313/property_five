class AlterProductTypeId < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :product_type_id, :integer, null: true
  end
end
