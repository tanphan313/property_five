module AdminProductSearchable
  extend ActiveSupport::Concern

  RANSACK_MAP_KEYS = {
    title: :title_cont,
    product_type_id: :product_type_id_eq,
    product_category_id: :product_category_id_eq,
    project: :project_cont,
    house_direction: :house_direction_eq,
    balcony_direction: :balcony_direction_eq,
    contact_email: :contact_email_eq,
    contact_phone: :contact_phone_eq,
    contact_mobile_phone: :contact_mobile_phone_eq,
  }

  private
  def search_params
    SearchParams.(params.fetch(:q, {}), RANSACK_MAP_KEYS)
  end

  def price_range_params
    min = params[:min_price] || 0
    max = params[:max_price] || 9223372036854775807
    min..max
  end
end
