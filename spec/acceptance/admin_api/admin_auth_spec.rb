require "acceptance_helper"
require "pp"

resource "Admin Authentication" do
  explanation "Endpoints for admin signin"
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let!(:admin){admins(:default_admin)}

  post "/admin_api/admin_auth/sign_in.json" do
    parameter :email, "Admin's email"
    parameter :password, "Admin's password"
    let(:raw_post) {params.to_json}

    example_request "Signing in",
      email: "admin@proper.co",
      password: "Pa$$word123" do

      expect(status).to eq(200)
    end

    example_request "Signing in with wrong password",
      email: "admin@proper.co",
      password: "password1234" do

      json = JSON.parse(response_body)
      errors = json["errors"]
      expect(errors).not_to be_empty
      expect(errors[0]).to eq("Invalid login credentials. Please try again.")
      expect(status).to eq(422)
    end
  end
end
