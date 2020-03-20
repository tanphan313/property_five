require "acceptance_helper"

resource "admin_api/products" do
  header "Accept", "application/json"
  header "Content-Type", "multipart/form-data"

  include_context "shared admin authentication"

  context "Index product" do
    parameter :title, "product name", scope: :q
    
    context "Search" do
      get "/admin_api/products.json" do
        example_request "Search products index with name" do
          json = JSON.parse(response_body)
          expect(status).to eq(200)
        end
      end
    end
  end

  context "Show product" do
    parameter :id, "product id"

    get "admin_api/products/:id.json" do
      let(:default_product){products(:default_product)}
      let(:id){default_product.id}

      example_request "Return product with full information" do
        json = JSON.parse(response_body)
        expect(json["title"]).to eq "Product title"
        expect(status).to eq(200)
      end
    end
  end

  shared_examples "parameters for create/update" do
    parameter :title, "String", scope: :product
    parameter :product_type_id, "String", scope: :product
    parameter :product_category_id, "String", scope: :product
    parameter :project, "String", scope: :product
    parameter :acreage, "String", scope: :product
    parameter :price, "String", scope: :product
    parameter :price_type_id, "String", scope: :product
    parameter :description, "String", scope: :product
    parameter :facade, "String", scope: :product
    parameter :entrance, "String", scope: :product
    parameter :house_direction, "String", scope: :product
    parameter :bacony_direction, "String", scope: :product
    parameter :num_floor, "String", scope: :product
    parameter :num_bedroom, "String", scope: :product
    parameter :num_toilet, "String", scope: :product
    parameter :furniture, "String", scope: :product
    parameter :contact_name, "String", scope: :product
    parameter :contact_address, "String", scope: :product
    parameter :contact_phone, "String", scope: :product
    parameter :contact_mobile_phone, "String", scope: :product
    parameter :contact_email, "String", scope: :product

    parameter :address_attributes, "String", scope: :product
    parameter :id, "String", scope: :address_attributes
    parameter :city_id, "String", scope: :address_attributes
    parameter :district_id, "String", scope: :address_attributes
    parameter :ward_id, "String", scope: :address_attributes
    parameter :street, "String", scope: :address_attributes
    parameter :full_name, "String", scope: :address_attributes

    parameter :product_images_attributes, "String", scope: :product
    parameter :id, "String", scope: :product_images_attributes
    parameter :attachment, "String", scope: :product_images_attributes
    parameter :_destroy, "String", scope: :product_images_attributes
    parameter :description, "String", scope: :product_images_attributes
    parameter :master, "String", scope: :product_images_attributes
  end

  context "Create product" do
    include_examples "parameters for create/update"

    context "Create product with correct params", :vcr do
      post "admin_api/products.json" do
        let(:default_product_type){product_types(:default_product_type)}
        let(:default_product_category){product_categories(:default_product_category)}
        let(:default_price_type){price_types(:default_price_type)}
        let(:ha_noi){cities(:ha_noi)}
        let(:ba_dinh){districts(:ba_dinh)}
        let(:cong_vi){wards(:cong_vi)}
        let(:image){File.open(Rails.root.join("test/files/image.jpg"))}

        let(:title){"String"}
        let(:project){"String"}
        let(:acreage){30.8}
        let(:price){30.8}
        let(:price_type_id){default_price_type.id}
        let(:product_type_id){default_product_type.id}
        let(:product_category_id){default_product_category.id}
        let(:description){"String"}
        let(:facade){30.8}
        let(:entrance){30.8}
        let(:house_direction){"north"}
        let(:bacony_direction){"north"}
        let(:num_floor){1}
        let(:num_bedroom){1}
        let(:num_toilet){1}
        let(:num_toilet){"String"}
        let(:contact_name){"String"}
        let(:contact_address){"String"}
        let(:contact_phone){"0987654321"}
        let(:contact_mobile_phone){"0987654321"}
        let(:contact_email){"contact@gmail.com"}

        let(:address_attributes) do
          {
            city_id: ha_noi.id,
            district_id: ba_dinh.id,
            ward_id: cong_vi.id,
            full_name: "String"
          }
        end

        let(:product_images_attributes) do
          [
            {
              master: true,
              attachment: Rack::Test::UploadedFile.new(image, "image/jpg")
            },
            {
              attachment: Rack::Test::UploadedFile.new(image, "image/jpg")
            }
          ]
        end

        example_request "Create product" do
          json = JSON.parse(response_body)
          expect(json).not_to be_empty
          expect(status).to eq(201)
        end
      end
    end
  end

  context "Update product" do
    include_examples "parameters for create/update"

    context "Update product with correct params", :vcr do
      put "admin_api/products/:id.json" do
        let!(:default_product) {products(:default_product)}

        let(:default_product_type){product_types(:default_product_type)}
        let(:default_product_category){product_categories(:default_product_category)}
        let(:default_price_type){price_types(:default_price_type)}
        let(:ha_noi){cities(:ha_noi)}
        let(:ba_dinh){districts(:ba_dinh)}
        let(:cong_vi){wards(:cong_vi)}
        let(:image){File.open(Rails.root.join("test/files/image.jpg"))}

        let(:title){"String"}
        let(:project){"String"}
        let(:acreage){30.8}
        let(:price){30.8}
        let(:price_type_id){default_price_type.id}
        let(:product_type_id){default_product_type.id}
        let(:product_category_id){default_product_category.id}
        let(:description){"String"}
        let(:facade){30.8}
        let(:entrance){30.8}
        let(:house_direction){"north"}
        let(:bacony_direction){"north"}
        let(:num_floor){1}
        let(:num_bedroom){1}
        let(:num_toilet){1}
        let(:num_toilet){"String"}
        let(:contact_name){"String"}
        let(:contact_address){"String"}
        let(:contact_phone){"0987654321"}
        let(:contact_mobile_phone){"0987654321"}
        let(:contact_email){"contact@gmail.com"}

        let(:address_attributes) do
          {
            id: default_product.address.id,
            city_id: ha_noi.id,
            district_id: ba_dinh.id,
            ward_id: cong_vi.id,
            full_name: "String"
          }
        end

        let(:product_images_attributes) do
          [
            {
              master: true,
              attachment: Rack::Test::UploadedFile.new(image, "image/jpg")
            },
            {
              attachment: Rack::Test::UploadedFile.new(image, "image/jpg")
            }
          ]
        end

        let(:id){default_product.id}
        example_request "Update product" do
          json = JSON.parse(response_body)
          expect(json).not_to be_empty
          expect(status).to eq(201)
        end
      end
    end
  end
end
