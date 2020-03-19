module Supports
  class DistrictsController < ApplicationController
    RANSACK_MAP_KEYS = {
      name: :name_cont,
      city_id: :city_id_eq,
      any_text: :name_or_name_with_type_or_path_or_path_with_type_or_slug_cont
    }

    def index
      @districts = District.ransack(search_params).result.order_by_slug.page(params[:page]).per(params[:per_page])
      render json: {
        results: @districts,
        total_count: District.count
      }
    end

    private
    def search_params
      SearchParams.(params.fetch(:q, {}), RANSACK_MAP_KEYS)
    end
  end
end
