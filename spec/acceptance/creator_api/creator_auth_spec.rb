require "acceptance_helper"
require "pp"

resource "Creator Authentication" do
  explanation "Endpoints for creator signin"
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let!(:creator){creators(:default_creator)}

  post "/creator_api/creator_auth/sign_in.json" do
    parameter :email, "Creator's email"
    parameter :password, "Creator's password"
    let(:raw_post) {params.to_json}

    example_request "Signing in",
      email: "creator@proper.co",
      password: "Pa$$word123" do

      expect(status).to eq(200)
    end

    example_request "Signing in with wrong password",
      email: "creator@proper.co",
      password: "password1234" do

      json = JSON.parse(response_body)
      errors = json["errors"]
      expect(errors).not_to be_empty
      expect(errors[0]).to eq("Invalid login credentials. Please try again.")
      expect(status).to eq(422)
    end
  end
end
