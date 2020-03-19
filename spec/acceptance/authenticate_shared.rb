RSpec.shared_context "shared admin authentication", :shared_context => :metadata do
  let!(:admin) {admins(:default_admin)}

  before do
    admin.update tokens: {"QSI6sSpitvV3Tw44juukqg": {"token": "#{::BCrypt::Password.create('OKmKselVr7pVDg1P8QQGVg')}", "expiry": 2573549729, "last_token": nil, "updated_at": Time.current}}
    auth_headers = admin.build_auth_header("OKmKselVr7pVDg1P8QQGVg", admin.tokens.first[0])
    auth_headers.each do |k, v|
      header k, v
    end
  end
end

RSpec.shared_context "shared creator authentication", :shared_context => :metadata do
  let!(:creator) {creators(:default_creator)}

  before do
    creator.update tokens: {"QSI6sSpitvV3Tw44juukqg": {"token": "#{::BCrypt::Password.create('OKmKselVr7pVDg1P8QQGVg')}", "expiry": 2573549729, "last_token": nil, "updated_at": Time.current}}
    auth_headers = creator.build_auth_header("OKmKselVr7pVDg1P8QQGVg", creator.tokens.first[0])
    auth_headers.each do |k, v|
      header k, v
    end
  end
end
