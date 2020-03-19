module Admin::Support
  class MasterDatasController < Admin::ApplicationController
    def show
      @master_data = {
        cities: City.order_by_slug.map{|city| city.attributes},
        districts: District.order_by_slug.map{|district| district.attributes},
        wards: Ward.order_by_slug.map{|ward| ward.attributes}
      }

      render json: {master_data: @master_data}, status: :ok
    end
  end
end
