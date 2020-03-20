require "acceptance_helper"

resource "creator_api/products" do
  header "Accept", "application/json"
  header "Content-Type", "multipart/form-data"

  include_context "shared creator authentication"

  context "Index product" do
    parameter :title, "product name", scope: :q
    
    context "Search" do
      get "/creator_api/products.json" do
        example_request "Search products index with name" do
          json = JSON.parse(response_body)
          expect(status).to eq(200)
        end
      end
    end
  end

  context "Show product" do
    parameter :id, "product id"

    get "creator_api/products/:id.json" do
      let(:default_product){products(:default_product)}
      let(:id){default_product.id}

      example_request "Return product with full information" do
        json = JSON.parse(response_body)
        expect(json["title"]).to eq "Product title"
        expect(status).to eq(200)
      end
    end
  end

  context "Create product" do
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
    parameter :city_id, "String", scope: :address_attributes
    parameter :district_id, "String", scope: :address_attributes
    parameter :ward_id, "String", scope: :address_attributes
    parameter :street, "String", scope: :address_attributes
    parameter :full_name, "String", scope: :address_attributes

    parameter :product_images_attributes, "String", scope: :product
    parameter :attachment, "String", scope: :product_images_attributes
    parameter :_destroy, "String", scope: :product_images_attributes
    parameter :description, "String", scope: :product_images_attributes
    parameter :master, "String", scope: :product_images_attributes

    context "Create product with correct params", :vcr do
      post "creator_api/products.json" do
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

        example_request "create and return product with full information" do
          json = JSON.parse(response_body)
          expect(json).not_to be_empty
          expect(status).to eq(201)
        end
      end
    end
  end

  #context "Update product" do
  #  parameter :id, "product's id"
  #  parameter :name, "product's name", scope: :product
  #  parameter :vendor_company_id, "product's vendor company id", scope: :product
  #  parameter :description, "product's description", scope: :product
  #  parameter :city, "product's city", scope: :product
  #  parameter :address_state_id, "product address_state_id(get addres_state_id master data from vendor/supports/master_datas.json)", scope: :product
  #
  #  parameter :logo_attributes, "nested params for product's logo", scope: :product
  #  parameter :id, "image id(has already been returned with product info)", scope: :logo_attributes
  #  parameter :variation, "image variation(value = 'logo')", scope: :logo_attributes
  #  parameter :attachment, "nested params for product's logo", scope: :logo_attributes
  #
  #  parameter :main_image_attributes, "nested params for product's main image", scope: :product
  #  parameter :id, "image id(has already been returned with product info)", scope: :main_image_attributes
  #  parameter :variation, "image variation(value = 'main')", scope: :main_image_attributes
  #  parameter :attachment, "nested params for product's main image", scope: :main_image_attributes
  #
  #  parameter :sub_images_attributes, "nested params for product's sub images, can upload multiple images", scope: :product
  #  parameter :id, "image id(has already been returned with product info)", scope: :sub_images_attributes
  #  parameter :_destroy, "= true if vendor wants to delete this pic", scope: :sub_images_attributes
  #  parameter :variation, "image variation(value = 'sub')", scope: :sub_images_attributes
  #  parameter :attachment, "nested params for product's sub images", scope: :sub_images_attributes
  #
  #  parameter :product_commission_attributes, "nested params for product's commission", scope: :product
  #  parameter :id, "product commission id", scope: :product_commission_attributes
  #  parameter :percentage, "percentage", scope: :product_commission_attributes
  #  parameter :_destroy, "= true if true if admin wants to delete this product commission", scope: :product_commission_attributes
  #
  #  context "Update product with correct params" do
  #    put "creator_api/products/:id.json" do
  #      let!(:candy) {products(:candy)}
  #      let!(:logo){images(:logo)}
  #      let!(:main_image){images(:main_image)}
  #      let!(:sub_image_1){images(:sub_image_1)}
  #      let!(:state_alaska) {address_states(:state_alaska)}
  #      let!(:image){File.open(Rails.root.join("test/files/image.jpg"))}
  #      let!(:image_2){File.open(Rails.root.join("test/files/image_2.jpg"))}
  #
  #      before do
  #        logo.update attachment: image
  #        main_image.update attachment: image
  #        sub_image_1.update attachment: image
  #      end
  #
  #      let(:id){candy.id}
  #      let(:name){"Super cute tea with new name"}
  #      let(:description){"Mr good tea"}
  #      let(:city){"Newyork"}
  #      let(:address_state_id){state_alaska.id}
  #
  #      let(:logo_attributes) do
  #        {
  #          id: logo.id,
  #          attachment: Rack::Test::UploadedFile.new(image_2, "image/jpg")
  #        }
  #      end
  #
  #      let(:main_image_attributes) do
  #        {
  #          id: main_image.id,
  #          attachment: Rack::Test::UploadedFile.new(image_2, "image/jpg")
  #        }
  #      end
  #
  #      let(:sub_images_attributes) do
  #        [
  #          {
  #            id: sub_image_1.id,
  #            _destroy: true
  #          }
  #        ]
  #      end
  #
  #      let(:product_commission_attributes) do
  #        {
  #          percentage: 10.0
  #        }
  #      end
  #
  #      example_request "Update product name and logo and main image" do
  #        json = JSON.parse(response_body)
  #        expect(json).not_to be_empty
  #        expect(json["name"]).to eq "Super cute tea with new name"
  #        expect(json["logo_attributes"]["url"]).to eq "http://localhost:3000/images/#{logo.id}/product/image_2.jpg"
  #        expect(json["main_image_attributes"]["url"]).to eq "http://localhost:3000/images/#{main_image.id}/product/image_2.jpg"
  #        expect(json["sub_images_attributes"].size).to eq 1
  #        expect(json["product_commission_attributes"]["percentage"]).to eq "10.0"
  #        expect(status).to eq(201)
  #      end
  #    end
  #  end
  #
  #  context "Update product with incorrect params" do
  #    put "creator_api/products/:id.json" do
  #      let!(:candy) {products(:candy)}
  #      let!(:logo){images(:logo)}
  #      let!(:default_file){File.open(Rails.root.join("test/files/default.pdf"))}
  #      let!(:image){File.open(Rails.root.join("test/files/image.jpg"))}
  #
  #      before do
  #        logo.update attachment: image
  #      end
  #
  #      let(:id){candy.id}
  #
  #      let(:logo_attributes) do
  #        {
  #          id: logo.id,
  #          attachment: Rack::Test::UploadedFile.new(default_file, "application/pdf")
  #        }
  #      end
  #
  #      example_request "Do not update product and Return error messages" do
  #        json = JSON.parse(response_body)
  #        expect(json).not_to be_empty
  #        expect(json["errors"]).to include "Logo attachment content type is invalid"
  #        expect(status).to eq(422)
  #      end
  #    end
  #  end
  #
  #  context "Update product with destroy commission" do
  #    put "creator_api/products/:id.json" do
  #      let(:specific_commission_product){products(:specific_commission_product)}
  #      let(:specific_commission_product_commission){product_commissions(:specific_commission_product_commission)}
  #
  #      let(:id){specific_commission_product.id}
  #
  #      let(:product_commission_attributes) do
  #        {
  #          id: specific_commission_product_commission.id,
  #          _destroy: true
  #        }
  #      end
  #
  #      example_request "Update product with destroy commission" do
  #        json = JSON.parse(response_body)
  #        expect(json["product_commission_attributes"]).to be_blank
  #        expect(status).to eq(201)
  #      end
  #    end
  #  end
  #end
end
