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

ActiveRecord::Schema[8.0].define(version: 2025_05_14_212341) do
  create_table "categories", force: :cascade do |t|
    t.boolean "visible", default: true, null: false
    t.string "name", limit: 30, null: false
    t.text "description", limit: 150
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_categories_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_categories_on_user_id"
    t.check_constraint "length(description) <= 150", name: "check_categories_description_length"
    t.check_constraint "length(name) <= 30", name: "check_categories_name_length"
    t.check_constraint "visible IN (0, 1)", name: "check_categories_visible_boolean"
  end

  create_table "products", force: :cascade do |t|
    t.boolean "visible", default: true, null: false
    t.boolean "featured", default: false, null: false
    t.string "code", limit: 50
    t.string "name", limit: 150, null: false
    t.text "description", limit: 5000
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.integer "sale_price_cents"
    t.string "sale_price_currency"
    t.datetime "sale_starts_at"
    t.datetime "sale_ends_at"
    t.datetime "available_from"
    t.datetime "available_until"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "code"], name: "index_products_on_user_id_and_code", unique: true, where: "code IS NOT NULL AND code <> ''"
    t.index ["user_id", "name"], name: "index_products_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_products_on_user_id"
    t.check_constraint "available_from IS NULL OR available_until IS NULL OR available_from < available_until", name: "check_products_available_range"
    t.check_constraint "code IS NULL OR length(code) <= 50", name: "check_products_code_length"
    t.check_constraint "description IS NULL OR length(description) <= 5000", name: "check_products_description_length"
    t.check_constraint "featured IN (0, 1)", name: "check_products_featured_boolean"
    t.check_constraint "length(name) <= 150", name: "check_products_name_length"
    t.check_constraint "price_cents >= 0", name: "check_products_price_nonnegative"
    t.check_constraint "sale_price_cents IS NULL OR sale_price_cents < price_cents", name: "check_products_sale_price_lt_price"
    t.check_constraint "sale_price_cents IS NULL OR sale_price_cents >= 0", name: "check_products_sale_price_nonnegative"
    t.check_constraint "sale_starts_at IS NULL OR sale_ends_at IS NULL OR sale_starts_at < sale_ends_at", name: "check_products_sale_range"
    t.check_constraint "visible IN (0, 1)", name: "check_products_visible_boolean"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "users", on_delete: :cascade
  add_foreign_key "products", "users", on_delete: :cascade
end
