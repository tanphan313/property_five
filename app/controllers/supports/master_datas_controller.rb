module Supports
  class MasterDatasController < ApplicationController
    def show
      @master_data = {
        cities: City.order_by_slug.map{|city| city.attributes},
        districts: District.order_by_slug.map{|district| district.attributes},
        product_categories: ProductCategory.order_by_name.map{|cat| {id: cat.id, name: cat.name}},
        product_amenities: ProductAmenity.order_by_name.map{|ame| {id: ame.id, name: ame.name}},
        house_directions: Product.house_directions.map{|key, _value| {name: key, id: key}},
        balcony_directions: Product.balcony_directions.map{|key, _value| {name: key, id: key}}
      }

      render json: {master_data: @master_data}, status: :ok
    end
  end
end
