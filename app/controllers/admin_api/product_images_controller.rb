module AdminApi
  class ProductImagesController < ::ProductImagesController
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_admin!
  end
end
