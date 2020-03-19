RSpec::Matchers.define :violate_db_constraint do |constraint_name| 
  # tell rspec to support blocks
  supports_block_expectations
  match do |code_to_test|
    begin
      code_to_test.()
      # fail the test since no exception thrown
      false
    rescue ActiveRecord::StatementInvalid => ex
      ex.message =~ /#{constraint_name}/
    end
  end
end