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

ActiveRecord::Schema[8.0].define(version: 2025_08_28_154352) do
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

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "catalogs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", limit: 30, null: false
    t.string "slug", limit: 30, null: false
    t.text "description", limit: 150
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_catalogs_on_slug", unique: true
    t.index ["user_id", "name"], name: "index_catalogs_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_catalogs_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "catalog_id", null: false
    t.string "name", limit: 30, null: false
    t.text "description", limit: 150
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catalog_id", "name"], name: "index_categories_on_catalog_id_and_name", unique: true
    t.index ["catalog_id"], name: "index_categories_on_catalog_id"
  end

  create_table "customers", force: :cascade do |t|
    t.integer "catalog_id", null: false
    t.integer "user_id"
    t.string "token", limit: 36, null: false
    t.string "email"
    t.string "phone", limit: 16
    t.string "name", limit: 150
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catalog_id", "email"], name: "index_customers_on_catalog_id_and_email", unique: true
    t.index ["catalog_id", "phone"], name: "index_customers_on_catalog_id_and_phone", unique: true
    t.index ["catalog_id", "token"], name: "index_customers_on_catalog_id_and_token", unique: true
    t.index ["catalog_id", "user_id"], name: "index_customers_on_catalog_id_and_user_id", unique: true
    t.index ["catalog_id"], name: "index_customers_on_catalog_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "variant_id", null: false
    t.integer "customer_id"
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "variant_id"], name: "index_line_items_on_customer_id_and_variant_id", unique: true
    t.index ["customer_id"], name: "index_line_items_on_customer_id"
    t.index ["variant_id", "customer_id"], name: "index_line_items_on_variant_id_and_customer_id"
    t.index ["variant_id"], name: "index_line_items_on_variant_id"
  end

  create_table "option_groups", force: :cascade do |t|
    t.integer "catalog_id", null: false
    t.string "name", limit: 30, null: false
    t.integer "minimum_selections", default: 1, null: false
    t.integer "maximum_selections"
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catalog_id", "name"], name: "index_option_groups_on_catalog_id_and_name", unique: true
    t.index ["catalog_id"], name: "index_option_groups_on_catalog_id"
  end

  create_table "options", force: :cascade do |t|
    t.integer "option_group_id", null: false
    t.string "name", limit: 50, null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_group_id", "name"], name: "index_options_on_option_group_id_and_name", unique: true
    t.index ["option_group_id"], name: "index_options_on_option_group_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "product_id"], name: "index_product_categories_on_category_id_and_product_id"
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id", "category_id"], name: "index_product_categories_on_product_id_and_category_id", unique: true
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "product_option_groups", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "option_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_group_id", "product_id"], name: "index_product_option_groups_on_option_group_id_and_product_id"
    t.index ["option_group_id"], name: "index_product_option_groups_on_option_group_id"
    t.index ["product_id", "option_group_id"], name: "index_product_option_groups_on_product_id_and_option_group_id", unique: true
    t.index ["product_id"], name: "index_product_option_groups_on_product_id"
  end

  create_table "product_property_groups", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "property_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "property_group_id"], name: "idx_on_product_id_property_group_id_a2903aef74", unique: true
    t.index ["product_id"], name: "index_product_property_groups_on_product_id"
    t.index ["property_group_id", "product_id"], name: "idx_on_property_group_id_product_id_431a475453"
    t.index ["property_group_id"], name: "index_product_property_groups_on_property_group_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "catalog_id", null: false
    t.string "name", limit: 150, null: false
    t.string "slug", limit: 150, null: false
    t.string "code", limit: 50
    t.text "description", limit: 5000
    t.boolean "adult_only", default: false, null: false
    t.boolean "featured", default: false, null: false
    t.boolean "visible", default: true, null: false
    t.datetime "available_from"
    t.datetime "available_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catalog_id", "code"], name: "index_products_on_catalog_id_and_code", unique: true
    t.index ["catalog_id", "name"], name: "index_products_on_catalog_id_and_name", unique: true
    t.index ["catalog_id", "slug"], name: "index_products_on_catalog_id_and_slug", unique: true
    t.index ["catalog_id"], name: "index_products_on_catalog_id"
  end

  create_table "properties", force: :cascade do |t|
    t.integer "property_group_id", null: false
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_group_id", "name"], name: "index_properties_on_property_group_id_and_name", unique: true
    t.index ["property_group_id"], name: "index_properties_on_property_group_id"
  end

  create_table "property_groups", force: :cascade do |t|
    t.integer "catalog_id", null: false
    t.string "name", limit: 30, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catalog_id", "name"], name: "index_property_groups_on_catalog_id_and_name", unique: true
    t.index ["catalog_id"], name: "index_property_groups_on_catalog_id"
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

  create_table "variant_properties", force: :cascade do |t|
    t.integer "variant_id", null: false
    t.integer "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id", "variant_id"], name: "index_variant_properties_on_property_id_and_variant_id"
    t.index ["property_id"], name: "index_variant_properties_on_property_id"
    t.index ["variant_id", "property_id"], name: "index_variant_properties_on_variant_id_and_property_id", unique: true
    t.index ["variant_id"], name: "index_variant_properties_on_variant_id"
  end

  create_table "variants", force: :cascade do |t|
    t.integer "product_id", null: false
    t.string "code", limit: 50
    t.string "property_combination"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.integer "stock_quantity"
    t.boolean "primary", default: false, null: false
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "code"], name: "index_variants_on_product_id_and_code", unique: true
    t.index ["product_id", "property_combination"], name: "index_variants_on_product_id_and_property_combination", unique: true, where: "\"primary\" = 0 AND property_combination IS NOT NULL"
    t.index ["product_id"], name: "index_variants_on_product_id"
    t.index ["product_id"], name: "index_variants_on_product_id_and_primary", unique: true, where: "\"primary\" = 1"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "catalogs", "users", on_delete: :cascade
  add_foreign_key "categories", "catalogs", on_delete: :cascade
  add_foreign_key "customers", "catalogs", on_delete: :cascade
  add_foreign_key "customers", "users", on_delete: :nullify
  add_foreign_key "line_items", "customers", on_delete: :cascade
  add_foreign_key "line_items", "variants", on_delete: :cascade
  add_foreign_key "option_groups", "catalogs", on_delete: :cascade
  add_foreign_key "options", "option_groups", on_delete: :cascade
  add_foreign_key "product_categories", "categories", on_delete: :restrict
  add_foreign_key "product_categories", "products", on_delete: :cascade
  add_foreign_key "product_option_groups", "option_groups", on_delete: :restrict
  add_foreign_key "product_option_groups", "products", on_delete: :cascade
  add_foreign_key "product_property_groups", "products", on_delete: :cascade
  add_foreign_key "product_property_groups", "property_groups", on_delete: :restrict
  add_foreign_key "products", "catalogs", on_delete: :cascade
  add_foreign_key "properties", "property_groups", on_delete: :cascade
  add_foreign_key "property_groups", "catalogs", on_delete: :cascade
  add_foreign_key "variant_properties", "properties", on_delete: :cascade
  add_foreign_key "variant_properties", "variants", on_delete: :cascade
  add_foreign_key "variants", "products", on_delete: :cascade
end
