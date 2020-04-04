class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :address
      t.integer :property_type, default: 0
      t.float :property_age
      t.float :acreage
      t.float :land_acreage
      t.boolean :checked, default: false
      t.string :note

      t.timestamps null: false
    end
  end
end
