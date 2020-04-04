class SearchController < ApplicationController
  MAP_ATTRIBUTES = {
    title: :title_cont,
    product_type_id: :product_type_id_eq,
    product_category_id: :product_category_id_eq,
    product_amenity_ids: :product_amenity_ids_contains,
    city_id: :city_id_eq,
    district_id: :district_id_eq,
    ward_id: :ward_id_eq,
    featured: :featured_eq,
    lat: :lat_lt,
    lng: :lng_gt
  }.freeze

  def index
    search_scope = if params[:term].present?
      Search.search_ids(params[:term]).score_sort
    else
      Search
    end
    @searches = search_scope.ransack(search_params).result.within_price_range(price_range_params)
      .within_acreage_range(acreage_range_params)
      .includes(searchable: :product_images).page(params[:page]).per(params[:per_page])
    @presenters = @searches.map {|search| ProductPresenter.new(search.searchable)}
  end

  private
  def search_params
    filter_params.merge(sort_params)
  end

  def filter_params
    SearchParams.(params.fetch(:q, {}), MAP_ATTRIBUTES)
  end

  def sort_params
    sort = params[:sort] ? params[:sort] : "title"
    direction = params[:direction] ? params[:direction] : "asc"
    attr = "#{sort} #{direction}"
    {sorts: attr}
  end

  def price_range_params
    min = params[:min_price] || 0
    max = params[:max_price] || 9223372036854775807
    min..max
  end

  def acreage_range_params
    min = params[:min_acreage] || 0.0
    max = params[:max_acreage] || 9223372036854775807.0
    min..max
  end
end
