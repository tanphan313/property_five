json.set! :results do
  json.array!(@presenters) do |presenter|
    json.(presenter, :id, :created_at, :title, :price, :product_type_id, :product_category_id,
      :project, :master_image_small_url, :master_image_medium_url,
      :address_full_name, :address, :city_name, :district_name, :ward_name,
      :editor_id, :editor_email, :editor_type)
  end
end

json.set! :num_pages, @products.total_pages
json.set! :num_results, @products.total_count
json.set! :current_page, @products.current_page
json.set! :page_size, @products.current_per_page
