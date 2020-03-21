json.set! :results do
  json.array!(@presenters) do |presenter|
    json.(presenter, :id, :title, :price, :product_type_id, :product_category_id,
      :project, :master_image_small_url, :master_image_medium_url,
      :address_full_name, :address, :city_name, :district_name, :ward_name)
  end
end

json.set! :num_pages, @products.total_pages
json.set! :num_results, @products.total_count
json.set! :current_page, @products.current_page
json.set! :page_size, @products.instance_variable_get("@_per")
