json.id address.id
json.city_id address.city_id
json.district_id address.district_id
json.ward_id address.ward_id
json.street address.street
json.full_name address.full_name
json.product_id address.product_id
json.lat address.lat.try(:to_f)
json.lng address.lng.try(:to_f)
