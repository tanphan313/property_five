module CreatorApi
  class ProductImagesController < ::ProductImagesController
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_creator!
  end
end
