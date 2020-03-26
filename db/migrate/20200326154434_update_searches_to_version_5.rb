class UpdateSearchesToVersion5 < ActiveRecord::Migration[5.1]
  def change
    update_view :searches, version: 5, revert_to_version: 4
  end
end
