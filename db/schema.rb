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

ActiveRecord::Schema.define(version: 20171015125146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_books", id: false, force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "author_id", null: false
    t.index ["author_id", "book_id"], name: "index_authors_books_on_author_id_and_book_id"
    t.index ["book_id", "author_id"], name: "index_authors_books_on_book_id_and_author_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.decimal "price", precision: 10, scale: 2
    t.text "description"
    t.integer "quantity"
    t.string "cover"
    t.string "additional_images", array: true
    t.integer "year"
    t.json "dimensions"
    t.integer "order_items_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_books_on_category_id"
  end

  create_table "books_materials", id: false, force: :cascade do |t|
    t.bigint "material_id", null: false
    t.bigint "book_id", null: false
    t.index ["book_id", "material_id"], name: "index_books_materials_on_book_id_and_material_id"
    t.index ["material_id", "book_id"], name: "index_books_materials_on_material_id_and_book_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "books_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "book_id"
    t.string "state"
    t.integer "score"
    t.text "body"
    t.string "title"
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shopping_cart_addresses", force: :cascade do |t|
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.bigint "country_id"
    t.string "type"
    t.string "first_name"
    t.string "last_name"
    t.string "city"
    t.string "address_line"
    t.string "zip"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "addressable_index"
    t.index ["country_id"], name: "index_shopping_cart_addresses_on_country_id"
  end

  create_table "shopping_cart_countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_coupons", force: :cascade do |t|
    t.string "code"
    t.integer "discount"
    t.date "expire"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_credit_cards", force: :cascade do |t|
    t.bigint "order_id"
    t.string "cvv"
    t.string "number"
    t.string "name_on_card"
    t.string "month_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shopping_cart_credit_cards_on_order_id"
  end

  create_table "shopping_cart_order_items", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "price", precision: 10, scale: 2
    t.string "product_type"
    t.bigint "product_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shopping_cart_order_items_on_order_id"
    t.index ["product_type", "product_id"], name: "productable_index"
  end

  create_table "shopping_cart_orders", force: :cascade do |t|
    t.decimal "total", precision: 10, scale: 2
    t.decimal "items_subtotal", precision: 10, scale: 2
    t.string "state"
    t.bigint "user_id"
    t.bigint "shipping_method_id"
    t.bigint "coupon_id"
    t.integer "total_quantity", default: 0
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_shopping_cart_orders_on_coupon_id"
    t.index ["shipping_method_id"], name: "index_shopping_cart_orders_on_shipping_method_id"
    t.index ["user_id"], name: "index_shopping_cart_orders_on_user_id"
  end

  create_table "shopping_cart_shipping_methods", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10, scale: 2
    t.integer "min_days"
    t.integer "max_days"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_shopping_cart_shipping_methods_on_country_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "books", "categories"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
  add_foreign_key "shopping_cart_addresses", "shopping_cart_countries", column: "country_id"
  add_foreign_key "shopping_cart_credit_cards", "shopping_cart_orders", column: "order_id"
  add_foreign_key "shopping_cart_order_items", "shopping_cart_orders", column: "order_id"
  add_foreign_key "shopping_cart_orders", "shopping_cart_coupons", column: "coupon_id"
  add_foreign_key "shopping_cart_orders", "shopping_cart_shipping_methods", column: "shipping_method_id"
  add_foreign_key "shopping_cart_orders", "users"
  add_foreign_key "shopping_cart_shipping_methods", "shopping_cart_countries", column: "country_id"
end
