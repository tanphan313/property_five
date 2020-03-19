# spec/support/factory_girl.rb
require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

# RSpec without Rails
# RSpec.configure do |config|
#   config.include FactoryGirl::Syntax::Methods

#   config.before(:suite) do
#     FactoryGirl.find_definitions
#   end
# end
