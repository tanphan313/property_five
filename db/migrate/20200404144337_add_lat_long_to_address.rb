class AddLatLongToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :lat, :decimal
    add_column :addresses, :lng, :decimal

    add_column :products, :featured, :boolean, default: false
  end
end
