module Admin
  class SessionsController < DeviseTokenAuth::SessionsController
    def render_create_success
      render "admin/admins/signed_in"
    end

    def render_create_error_bad_credentials
      render json: {
        errors: [I18n.t("devise_token_auth.sessions.bad_credentials")]
      }, status: :unprocessable_entity
    end
  end
end
