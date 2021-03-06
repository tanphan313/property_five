require 'acceptance_helper'

resource "Products" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  context "search products" do
    parameter :title, "String", scope: :q
    parameter :product_type_id, "String", scope: :q
    parameter :product_category_id, "String", scope: :q
    parameter :city_id, "String", scope: :q
    parameter :district_id, "String", scope: :q
    parameter :ward_id, "String", scope: :q
    parameter :term, "Search term"
    parameter :per_page, "Search term"

    get '/search.json' do
      let(:term){"Product title"}
      let(:per_page){90}
      example_request "Search return result" do
        json = JSON.parse(response_body)
        puts json
        expect(json["results"].size).to be > 0
        expect(status).to eq(200)
      end
    end
  end

  context "show product" do
    get '/products/:id.json' do
      let(:default_product){products(:default_product)}
      let(:id){default_product.id}

      example_request "Get detail information of product" do
        json = JSON.parse(response_body)
        expect(json["title"]).to eq "Product title"
        expect(status).to eq(200)
      end
    end
  end
end
