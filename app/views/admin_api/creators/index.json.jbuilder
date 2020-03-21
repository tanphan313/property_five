json.set! :results do
  json.array!(@creators) do |creator|
    json.(creator, :id, :name, :email)
  end
end

json.set! :num_pages, @creators.total_pages
json.set! :num_results, @creators.total_count
json.set! :current_page, @creators.current_page
json.set! :page_size, @creators.instance_variable_get("@_per")
