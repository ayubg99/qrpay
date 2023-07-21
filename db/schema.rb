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

ActiveRecord::Schema.define(version: 2023_07_21_134111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "cart_item_food_items", force: :cascade do |t|
    t.bigint "cart_item_id"
    t.bigint "food_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_cart_item_food_items_on_cart_item_id"
    t.index ["food_item_id"], name: "index_cart_item_food_items_on_food_item_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id"
    t.bigint "food_item_id"
    t.bigint "special_menu_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.bigint "deleted_order_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["deleted_order_id"], name: "index_cart_items_on_deleted_order_id"
    t.index ["food_item_id"], name: "index_cart_items_on_food_item_id"
    t.index ["order_id"], name: "index_cart_items_on_order_id"
    t.index ["special_menu_id"], name: "index_cart_items_on_special_menu_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
    t.datetime "last_active_at"
    t.index ["restaurant_id"], name: "index_carts_on_restaurant_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_categories_on_restaurant_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.string "phone_number"
    t.string "restaurant_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_revenues", force: :cascade do |t|
    t.decimal "revenue"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "month"
    t.integer "year"
    t.integer "day"
    t.date "date"
    t.index ["restaurant_id"], name: "index_daily_revenues_on_restaurant_id"
  end

  create_table "deleted_order_cart_items", force: :cascade do |t|
    t.bigint "deleted_order_id"
    t.bigint "cart_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_deleted_order_cart_items_on_cart_item_id"
    t.index ["deleted_order_id"], name: "index_deleted_order_cart_items_on_deleted_order_id"
  end

  create_table "deleted_order_food_items", force: :cascade do |t|
    t.bigint "deleted_order_id"
    t.bigint "food_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_order_id"], name: "index_deleted_order_food_items_on_deleted_order_id"
    t.index ["food_item_id"], name: "index_deleted_order_food_items_on_food_item_id"
  end

  create_table "deleted_order_special_menus", force: :cascade do |t|
    t.bigint "deleted_order_id"
    t.bigint "special_menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_order_id"], name: "index_deleted_order_special_menus_on_deleted_order_id"
    t.index ["special_menu_id"], name: "index_deleted_order_special_menus_on_special_menu_id"
  end

  create_table "deleted_orders", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "restaurant_id"
    t.decimal "total_price", precision: 8, scale: 2
    t.datetime "order_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price", precision: 8, scale: 2
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.integer "special_menu_id"
    t.integer "minimum_persons"
    t.index ["category_id"], name: "index_food_items_on_category_id"
    t.index ["restaurant_id"], name: "index_food_items_on_restaurant_id"
  end

  create_table "food_type_food_items", force: :cascade do |t|
    t.bigint "food_item_id"
    t.bigint "food_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_item_id"], name: "index_food_type_food_items_on_food_item_id"
    t.index ["food_type_id"], name: "index_food_type_food_items_on_food_type_id"
  end

  create_table "food_types", force: :cascade do |t|
    t.string "name"
    t.bigint "special_menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "have_to_select_one"
    t.index ["special_menu_id"], name: "index_food_types_on_special_menu_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "monthly_revenues", force: :cascade do |t|
    t.decimal "revenue"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.integer "month"
    t.index ["restaurant_id"], name: "index_monthly_revenues_on_restaurant_id"
  end

  create_table "order_food_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "food_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_item_id"], name: "index_order_food_items_on_food_item_id"
    t.index ["order_id"], name: "index_order_food_items_on_order_id"
  end

  create_table "order_special_menus", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "special_menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_special_menus_on_order_id"
    t.index ["special_menu_id"], name: "index_order_special_menus_on_special_menu_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "cart_id"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_method"
    t.decimal "total_price", precision: 8, scale: 2
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "slug"
    t.string "stripe_account_id"
    t.string "bank_account_number"
    t.string "bank_routing_number"
    t.string "bank_account_holder_name"
    t.index ["reset_password_token"], name: "index_restaurants_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_restaurants_on_slug", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "cart_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_sessions_on_cart_id"
  end

  create_table "special_menu_food_items", force: :cascade do |t|
    t.bigint "special_menu_id"
    t.bigint "food_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_item_id"], name: "index_special_menu_food_items_on_food_item_id"
    t.index ["special_menu_id"], name: "index_special_menu_food_items_on_special_menu_id"
  end

  create_table "special_menu_items", force: :cascade do |t|
    t.bigint "special_menu_id"
    t.bigint "food_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_item_id"], name: "index_special_menu_items_on_food_item_id"
    t.index ["special_menu_id"], name: "index_special_menu_items_on_special_menu_id"
  end

  create_table "special_menus", force: :cascade do |t|
    t.string "name"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price", precision: 8, scale: 2
    t.text "instructions"
    t.text "description"
    t.time "start_hour"
    t.time "end_hour"
    t.integer "minimum_persons"
    t.index ["restaurant_id"], name: "index_special_menus_on_restaurant_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "table_number"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_item_food_items", "cart_items", on_delete: :cascade
  add_foreign_key "cart_item_food_items", "food_items"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "deleted_orders"
  add_foreign_key "cart_items", "food_items"
  add_foreign_key "cart_items", "orders"
  add_foreign_key "cart_items", "special_menus"
  add_foreign_key "carts", "restaurants"
  add_foreign_key "categories", "restaurants"
  add_foreign_key "daily_revenues", "restaurants"
  add_foreign_key "deleted_order_cart_items", "cart_items"
  add_foreign_key "deleted_order_cart_items", "deleted_orders"
  add_foreign_key "deleted_order_food_items", "deleted_orders"
  add_foreign_key "deleted_order_food_items", "food_items"
  add_foreign_key "deleted_order_special_menus", "deleted_orders"
  add_foreign_key "deleted_order_special_menus", "special_menus"
  add_foreign_key "food_items", "categories"
  add_foreign_key "food_items", "restaurants"
  add_foreign_key "food_type_food_items", "food_items"
  add_foreign_key "food_type_food_items", "food_types", on_delete: :cascade
  add_foreign_key "food_types", "special_menus"
  add_foreign_key "monthly_revenues", "restaurants"
  add_foreign_key "order_food_items", "food_items"
  add_foreign_key "order_food_items", "orders"
  add_foreign_key "order_special_menus", "orders"
  add_foreign_key "order_special_menus", "special_menus"
  add_foreign_key "orders", "carts"
  add_foreign_key "orders", "restaurants"
  add_foreign_key "sessions", "carts"
  add_foreign_key "special_menu_food_items", "food_items"
  add_foreign_key "special_menu_food_items", "special_menus"
  add_foreign_key "special_menu_items", "food_items"
  add_foreign_key "special_menu_items", "special_menus", on_delete: :cascade
  add_foreign_key "special_menus", "restaurants"
  add_foreign_key "tables", "restaurants"
end
