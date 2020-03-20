require 'acceptance_helper'

resource "Products" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  parameter :title, "String", scope: :q
  parameter :product_type_id, "String", scope: :q
  parameter :product_category_id, "String", scope: :q
  parameter :city_id, "String", scope: :q
  parameter :district_id, "String", scope: :q
  parameter :ward_id, "String", scope: :q
  parameter :term, "Search term"

  get '/search.json' do
    example_request "Search return result" do
      json = JSON.parse(response_body)
      puts json
      expect(json["results"].size).to be > 0
      expect(status).to eq(200)
    end
  end
end
