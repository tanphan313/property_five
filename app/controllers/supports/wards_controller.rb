module Supports
  class WardsController < ApplicationController
    RANSACK_MAP_KEYS = {
      name: :name_cont,
      district_id: :district_id_eq,
      any_text: :name_or_name_with_type_or_path_or_path_with_type_or_slug_cont
    }

    def index
      @wards = Ward.ransack(search_params).result.order_by_slug.page(params[:page])
      render json: {
        results: @wards,
        total_count: Ward.count
      }
    end

    private
    def search_params
      SearchParams.(params.fetch(:q, {}), RANSACK_MAP_KEYS)
    end
  end
end
