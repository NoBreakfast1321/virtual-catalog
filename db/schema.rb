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

ActiveRecord::Schema[8.0].define(version: 2025_06_07_204220) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "businesses", force: :cascade do |t|
    t.text "description", limit: 150
    t.string "name", limit: 30, null: false
    t.string "slug", limit: 30, null: false
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["slug"], name: "index_businesses_on_slug", unique: true
    t.index ["user_id"], name: "index_businesses_on_user_id"
    t.check_constraint "description IS NULL OR length(description) <= 150", name: "check_businesses_description_length"
    t.check_constraint "length(name) <= 30", name: "check_businesses_name_length"
    t.check_constraint "length(slug) <= 30 AND slug GLOB '[a-z0-9_-]*'", name: "check_businesses_slug_format"
    t.check_constraint "visible IN (0, 1)", name: "check_businesses_visible_boolean"
  end

  create_table "categories", force: :cascade do |t|
    t.text "description", limit: 150
    t.string "name", limit: 30, null: false
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "business_id", null: false
    t.index ["business_id", "name"], name: "index_categories_on_business_id_and_name", unique: true
    t.index ["business_id"], name: "index_categories_on_business_id"
    t.check_constraint "description IS NULL OR length(description) <= 150", name: "check_categories_description_length"
    t.check_constraint "length(name) <= 30", name: "check_categories_name_length"
    t.check_constraint "visible IN (0, 1)", name: "check_categories_visible_boolean"
  end

  create_table "option_groups", force: :cascade do |t|
    t.integer "max_choices"
    t.integer "min_choices", default: 1, null: false
    t.string "name", limit: 30, null: false
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["product_id", "name"], name: "index_option_groups_on_product_id_and_name", unique: true
    t.index ["product_id"], name: "index_option_groups_on_product_id"
    t.check_constraint "length(name) <= 30", name: "check_option_groups_name_length"
    t.check_constraint "max_choices IS NULL OR max_choices >= min_choices", name: "check_option_groups_max_choices_gte_min_choices"
    t.check_constraint "min_choices >= 1", name: "check_option_groups_min_choices_gte_1"
    t.check_constraint "visible IN (0, 1)", name: "check_option_groups_visible_boolean"
  end

  create_table "options", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "price_variation_cents"
    t.string "price_variation_currency"
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "option_group_id", null: false
    t.index ["option_group_id", "name"], name: "index_options_on_option_group_id_and_name", unique: true
    t.index ["option_group_id"], name: "index_options_on_option_group_id"
    t.check_constraint "length(name) <= 50", name: "check_options_name_length"
    t.check_constraint "visible IN (0, 1)", name: "check_options_visible_boolean"
  end

  create_table "product_categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id", null: false
    t.integer "product_id", null: false
    t.index ["category_id", "product_id"], name: "index_product_categories_on_category_id_and_product_id"
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id", "category_id"], name: "index_product_categories_on_product_id_and_category_id", unique: true
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "available_from"
    t.datetime "available_until"
    t.string "code", limit: 50
    t.text "description", limit: 5000
    t.boolean "featured", default: false, null: false
    t.string "name", limit: 150, null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.datetime "sale_ends_at"
    t.integer "sale_price_cents"
    t.string "sale_price_currency"
    t.datetime "sale_starts_at"
    t.string "slug", limit: 150, null: false
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "business_id", null: false
    t.index ["business_id", "code"], name: "index_products_on_business_id_and_code", unique: true, where: "code IS NOT NULL AND code <> ''"
    t.index ["business_id", "name"], name: "index_products_on_business_id_and_name", unique: true
    t.index ["business_id", "slug"], name: "index_products_on_business_id_and_slug", unique: true
    t.index ["business_id"], name: "index_products_on_business_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "businesses", "users", on_delete: :cascade
  add_foreign_key "categories", "businesses", on_delete: :cascade
  add_foreign_key "option_groups", "products", on_delete: :cascade
  add_foreign_key "options", "option_groups", on_delete: :cascade
  add_foreign_key "product_categories", "categories", on_delete: :restrict
  add_foreign_key "product_categories", "products", on_delete: :cascade
  add_foreign_key "products", "businesses", on_delete: :cascade
end
