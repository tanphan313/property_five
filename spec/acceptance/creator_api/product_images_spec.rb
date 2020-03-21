require "acceptance_helper"

resource "creator_api/product_images" do
  header "Accept", "application/json"
  header "Content-Type", "multipart/form-data"

  include_context "shared creator authentication"

  shared_examples "parameters for create/update" do
    parameter :id, "String", scope: :product_image
    parameter :attachment, "String", scope: :product_image
    parameter :description, "String", scope: :product_image
    parameter :master, "String", scope: :product_image
  end

  context "Create product image" do
    include_examples "parameters for create/update"

    context "Create product with correct params", :vcr do
      post "creator_api/product_images.json" do
        let(:image){File.open(Rails.root.join("test/files/image.jpg"))}

        let(:attachment){Rack::Test::UploadedFile.new(image, "image/jpg")}
        let(:master){true}

        example_request "Create image" do
          json = JSON.parse(response_body)
          expect(json).not_to be_empty
          puts json
          expect(status).to eq(201)
        end
      end
    end
  end
end
