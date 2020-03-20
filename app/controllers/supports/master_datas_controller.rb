module Supports
  class MasterDatasController < ApplicationController
    def show
      @master_data = {
        cities: City.order_by_slug.map{|city| city.attributes},
        districts: District.order_by_slug.map{|district| district.attributes},
        product_types: ProductType.order_by_name.map do |type|
          {
            id: type.id,
            name: type.name,
            category_ids: type.product_category_ids,
            price_type_ids: type.price_type_ids
          }
        end,
        product_categories: ProductCategory.order_by_name.map{|cat| {id: cat.id, name: cat.name}},
        price_types: PriceType.order_by_name.map{|type| {id: type.id, name: type.name}},
        house_directions: Product.house_directions.map{|key, _value| {name: key, id: key}},
        bacony_direction: Product.bacony_directions.map{|key, _value| {name: key, id: key}}
      }

      render json: {master_data: @master_data}, status: :ok
    end
  end
end
