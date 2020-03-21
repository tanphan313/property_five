json.set! :results do
  json.array!(@presenters) do |presenter|
    json.partial! 'product_listings/product_listing', presenter: presenter
  end
end

json.set! :num_pages, @searches.total_pages
json.set! :num_results, @searches.total_count
json.set! :current_page, @searches.current_page
json.set! :page_size, @searches.current_per_page
