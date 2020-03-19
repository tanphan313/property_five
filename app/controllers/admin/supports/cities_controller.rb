module Admin::Supports
  class CitiesController < Admin::ApplicationController
    RANSACK_MAP_KEYS = {
      name: :name_cont,
      any_text: :name_or_name_with_type_or_slug_cont
    }

    def index
      @cities = City.ransack(search_params).result.order_by_slug.page(params[:page])
      render json: {
        results: @cities,
        total_count: City.count
      }
    end

    private
    def search_params
      SearchParams.(params.fetch(:q, {}), RANSACK_MAP_KEYS)
    end
  end
end
