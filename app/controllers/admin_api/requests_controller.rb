module AdminApi
  class RequestsController < ApplicationController
    FORM_PARAMS = %i(checked note)

    RANSACK_MAP_KEYS = {
      checked: :checked_eq,
      property_type: :property_type_eq
    }

    def index
      @requests = Request.ransack(search_params).result.newest.page(params[:page]).per(params[:per_page])
    end

    def show
      render :show, status: :ok
    end

    def update
      if request.update form_params
        render :update, status: :ok
      else
        render json: {errors: request.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def destroy
      request.destroy
      if request.destroyed?
        render json: {message: "Request deleted"}, status: :created
      else
        render json: {errors: request.errors.full_messages}, status: :unprocessable_entity
      end
    end

    private
    def search_params
      SearchParams.(params.fetch(:q, {}), RANSACK_MAP_KEYS)
    end

    def form_params
      @form_params ||= params.require(:request).permit(FORM_PARAMS)
    end

    def request
      @request ||= Request.find(params[:id])
    end
    helper_method :request
  end
end
