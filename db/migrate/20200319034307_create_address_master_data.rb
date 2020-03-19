class CreateAddressMasterData < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name, index: true
      t.string :slug
      t.string :variation
      t.string :name_with_type
      t.integer :code, index: true
    end

    create_table :districts do |t|
      t.string :name, index: true
      t.string :slug
      t.string :variation
      t.string :name_with_type
      t.string :path
      t.string :path_with_type
      t.integer :code, index: true

      t.references :city
    end

    create_table :wards do |t|
      t.string :name, index: true
      t.string :slug
      t.string :variation
      t.string :name_with_type
      t.string :path
      t.string :path_with_type
      t.integer :code, index: true

      t.references :district
    end
  end
end
