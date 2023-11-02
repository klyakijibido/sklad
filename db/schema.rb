# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_11_02_090632) do

  create_table "cash_registers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "disco_cards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "discount_cards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "operation_types", force: :cascade do |t|
    t.string "name", null: false
    t.integer "multiplier_cash", null: false
    t.integer "multiplier_quantity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_operation_types_on_name", unique: true
  end

  create_table "operations", force: :cascade do |t|
    t.datetime "date_created"
    t.integer "product_id", null: false
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.decimal "sale_price", precision: 10, scale: 2, null: false
    t.integer "discount_percent", null: false
    t.integer "operation_type_id", null: false
    t.integer "user_id", null: false
    t.integer "shop_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "disco_card_id", null: false
    t.integer "cash_register_id", null: false
    t.decimal "rest_before", precision: 10, scale: 2, null: false
    t.index ["cash_register_id"], name: "index_operations_on_cash_register_id"
    t.index ["disco_card_id"], name: "index_operations_on_disco_card_id"
    t.index ["operation_type_id"], name: "index_operations_on_operation_type_id"
    t.index ["product_id"], name: "index_operations_on_product_id"
    t.index ["shop_id"], name: "index_operations_on_shop_id"
    t.index ["user_id"], name: "index_operations_on_user_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "art"
    t.string "razd"
    t.string "sor"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.decimal "price_buy", precision: 10, scale: 2, null: false
    t.integer "code", null: false
    t.integer "provider_id", null: false
    t.integer "country_id", null: false
    t.integer "plant_id", null: false
    t.string "ean13"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_products_on_country_id"
    t.index ["plant_id"], name: "index_products_on_plant_id"
    t.index ["provider_id"], name: "index_products_on_provider_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", null: false
    t.string "full_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_shops_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "operations", "cash_registers"
  add_foreign_key "operations", "disco_cards"
  add_foreign_key "operations", "operation_types"
  add_foreign_key "operations", "products"
  add_foreign_key "operations", "shops"
  add_foreign_key "operations", "users"
  add_foreign_key "products", "countries"
  add_foreign_key "products", "plants"
  add_foreign_key "products", "providers"
end
