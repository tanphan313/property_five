require 'json'

namespace :refine_db do
  task create_admin: :environment do
    Admin.create name: "Admin", email: "admin@properfive.com", password: "Abc@12345"
  end

  task import_master_data: :environment do
    City.destroy_all

    city_file = File.read('db/json/city.json')
    city_hash = JSON.parse(city_file)

    puts "Start import City"
    city_hash.each do |_key, params|
      City.create params
    end
    puts "Finish importing #{City.count} cities"

    district_file = File.read('db/json/district.json')
    district_hash = JSON.parse(district_file)

    puts "Start import District"
    district_hash.map{|_key, val| val}.group_by{|val| val["parent_code"]}.each do |parent_code, children|
      city = City.find_by(code: parent_code)
      next unless city
      children.each do |child_params|
        city.districts.create child_params.except("parent_code")
      end
    end
    puts "Finish importing #{District.count} districts"

    ward_file = File.read('db/json/ward.json')
    ward_hash = JSON.parse(ward_file)

    puts "Start import Ward"
    ward_hash.map{|_key, val| val}.group_by{|val| val["parent_code"]}.each do |parent_code, children|
      district = District.find_by(code: parent_code)
      next unless district
      children.each do |child_params|
        district.wards.create child_params.except("parent_code")
      end
    end
    puts "Finish importing #{Ward.count} wards"
  end

  task import_product_types_and_categories_and_price_types: :environment do
    ProductType.destroy_all
    ProductCategory.destroy_all

    ["Nhà đất bán", "Nhà đất cho thuê"].each do |name|
      ProductType.create name: name
    end

    sell_type = ProductType.find_by(name: "Nhà đất bán")
    ["Bán căn hộ chung cư", "Bán nhà riêng", "Bán nhà biệt thự, liền kề", "Bán nhà mặt phố", "Bán đất nền dự án",
      "Bán đất", "Bán trang trại, khu nghỉ dưỡng", "Bán kho, nhà xưởng", "Bán loại bất động sản khác"].each do |name|
      product_cat = ProductCategory.create name: name
      ProductCategoriesType.create product_type: sell_type, product_category: product_cat
    end
    ["Triệu", "Tỷ", "Trăm nghìn/m2", "Triệu/m2"].each do |name|
      price_type = PriceType.create name: name
      ProductTypesPriceType.create product_type: sell_type, price_type: price_type
    end

    rent_type = ProductType.find_by(name: "Nhà đất cho thuê")
    ["Cho thuê căn hộ chung cư", "Cho thuê nhà riêng", "Cho thuê nhà mặt phố", "Cho thuê nhà trọ, phòng trọ",
      "Cho thuê văn phòng", "Cho thuê cửa hàng, ki ốt", "Cho thuê kho, nhà xưởng, đất", "Cho thuê loại bất động sản khác"].each do |name|
      product_cat = ProductCategory.create name: name
      ProductCategoriesType.create product_type: rent_type, product_category: product_cat
    end
    ["Trăm nghìn/tháng", "Triệu/tháng", "Trăm nghìn/m2/tháng", "Triệu/m2/tháng", "Nghìn/m2/tháng"].each do |name|
      price_type = PriceType.create name: name
      ProductTypesPriceType.create product_type: rent_type, price_type: price_type
    end

    concurrent_type = PriceType.create name: "Thỏa thuận"
    ProductTypesPriceType.create product_type: sell_type, price_type: concurrent_type
    ProductTypesPriceType.create product_type: rent_type, price_type: concurrent_type
  end
end
