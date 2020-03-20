require "rails_helper"
require "rspec_api_documentation"
require "rspec_api_documentation/dsl"
require_relative "./acceptance/authenticate_shared"

RspecApiDocumentation.configure do |config|
  config.format = [:json]
  config.curl_host = "http://localhost:3000"
  config.api_name = "ProperFive API"
  config.api_explanation = "API Example Description"
  config.request_headers_to_include = %w(Accept Content-Type Access-Token Token-Type Client Expiry Uid Host)
  config.response_headers_to_include = %w(Content-Type access-token token-type client expiry uid ETag)
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/test/fixtures"
  config.use_transactional_fixtures = true
  config.global_fixtures = :all
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end
