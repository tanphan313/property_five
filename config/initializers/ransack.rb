Ransack.configure do |config|
  config.add_predicate "contains",
    arel_predicate: "contains",
    formatter: proc { |v| "#{v}" },
    validator: proc { |v| v.present? },
    type: :string,
    wants_array: true
  config.sanitize_custom_scope_booleans = false
end
