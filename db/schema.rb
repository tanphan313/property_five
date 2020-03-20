# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200320073218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.bigint "district_id", null: false
    t.bigint "ward_id"
    t.string "street"
    t.string "full_name"
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["district_id"], name: "index_addresses_on_district_id"
    t.index ["product_id"], name: "index_addresses_on_product_id"
    t.index ["ward_id"], name: "index_addresses_on_ward_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.json "tokens"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "variation"
    t.string "name_with_type"
    t.integer "code"
    t.index ["code"], name: "index_cities_on_code"
    t.index ["name"], name: "index_cities_on_name"
  end

  create_table "creators", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.json "tokens"
    t.index ["email"], name: "index_creators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_creators_on_reset_password_token", unique: true
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "variation"
    t.string "name_with_type"
    t.string "path"
    t.string "path_with_type"
    t.integer "code"
    t.bigint "city_id"
    t.index ["city_id"], name: "index_districts_on_city_id"
    t.index ["code"], name: "index_districts_on_code"
    t.index ["name"], name: "index_districts_on_name"
  end

  create_table "price_types", force: :cascade do |t|
    t.bigint "product_id"
    t.string "name", null: false
    t.index ["product_id"], name: "index_price_types_on_product_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories_types", force: :cascade do |t|
    t.bigint "product_type_id", null: false
    t.bigint "product_category_id", null: false
    t.index ["product_category_id"], name: "index_product_categories_types_on_product_category_id"
    t.index ["product_type_id"], name: "index_product_categories_types_on_product_type_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.bigint "product_id"
    t.string "description"
    t.boolean "master", default: false
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_types_price_types", force: :cascade do |t|
    t.bigint "product_type_id"
    t.bigint "price_type_id"
    t.index ["price_type_id"], name: "index_product_types_price_types_on_price_type_id"
    t.index ["product_type_id"], name: "index_product_types_price_types_on_product_type_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "product_type_id", null: false
    t.bigint "product_category_id", null: false
    t.string "title"
    t.string "project"
    t.float "acreage"
    t.float "price"
    t.text "description"
    t.float "facade"
    t.float "entrance"
    t.integer "house_direction", default: 0
    t.integer "bacony_direction", default: 0
    t.integer "num_floor"
    t.integer "num_bedroom"
    t.integer "num_toilet"
    t.text "furniture"
    t.string "contact_name"
    t.string "contact_address"
    t.string "contact_phone"
    t.string "contact_mobile_phone"
    t.string "contact_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "editor_type"
    t.bigint "editor_id"
    t.bigint "price_type_id"
    t.index ["editor_type", "editor_id"], name: "index_products_on_editor_type_and_editor_id"
    t.index ["price_type_id"], name: "index_products_on_price_type_id"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
    t.index ["product_type_id"], name: "index_products_on_product_type_id"
  end

  create_table "wards", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "variation"
    t.string "name_with_type"
    t.string "path"
    t.string "path_with_type"
    t.integer "code"
    t.bigint "district_id"
    t.index ["code"], name: "index_wards_on_code"
    t.index ["district_id"], name: "index_wards_on_district_id"
    t.index ["name"], name: "index_wards_on_name"
  end

end
