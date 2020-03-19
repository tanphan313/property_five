require 'json'

namespace :refine_db do
  task create_admin: :environment do
    Admin.create name: "Admin", email: "admin@properfive.com"
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
end
