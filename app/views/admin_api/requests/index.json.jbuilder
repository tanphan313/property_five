json.set! :results do
  json.array!(@requests) do |request|
    json.partial! "shared/request", request: request
  end
end

json.set! :num_pages, @requests.total_pages
json.set! :num_results, @requests.total_count
json.set! :current_page, @requests.current_page
json.set! :page_size, @requests.current_per_page
