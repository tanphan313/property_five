module CreatorApi
  class ApplicationController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    rescue_from ActiveRecord::RecordNotFound, with: :render_error_notfound

    before_action :authenticate_creator!

    def render_error_notfound
      render json: {errors: "Record not found"}, status: 404
    end
  end
end
