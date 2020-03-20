class RenameBaconyToBalcony < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :bacony_direction, :balcony_direction
  end
end
