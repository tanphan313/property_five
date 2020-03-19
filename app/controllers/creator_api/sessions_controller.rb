module CreatorApi
  class SessionsController < DeviseTokenAuth::SessionsController
    def render_create_success
      render "creator_api/creators/signed_in"
    end

    def render_create_error_bad_credentials
      render json: {
        errors: [I18n.t("devise_token_auth.sessions.bad_credentials")]
      }, status: :unprocessable_entity
    end
  end
end
