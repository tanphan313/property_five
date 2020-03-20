class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_view :searches
  end
end
