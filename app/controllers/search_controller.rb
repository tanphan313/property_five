class SearchController < ApplicationController
  MAP_ATTRIBUTES = {
    title: :title_cont,
    product_type_id: :product_type_id_eq,
    product_category_id: :product_category_id_eq,
    city_id: :city_id_eq,
    district_id: :district_id_eq,
    ward_id: :ward_id_eq
  }.freeze

  def index
    search_scope = if params[:term].present?
      Search.search_ids(params[:term]).score_sort
    else
      Search
    end
    @searches = search_scope.ransack(search_params).result
      .includes(searchable: :product_images).page(params[:page]).per(params[:per_page])
    @presenters = @searches.map {|search| ProductPresenter.new(search.searchable)}
  end

  def show
    product = Product.find(params[:id])
    @presenter = ProductPresenter.new product
  end

  private
  def search_params
    filter_params.merge(sort_params)
  end

  def filter_params
    SearchParams.(
      params.fetch(:q, {}), MAP_ATTRIBUTES
    )
  end

  def sort_params
    sort = params[:sort] ? params[:sort] : "title"
    direction = params[:direction] ? params[:direction] : "asc"
    attr = "#{sort} #{direction}"
    {sorts: attr}
  end
end