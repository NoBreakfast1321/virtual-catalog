class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.boolean :visible, null: false, default: true
      t.boolean :featured, null: false, default: false
      t.string :code, limit: 50
      t.string :slug, null: false, limit: 150
      t.string :name, null: false, limit: 150
      t.text :description, limit: 5000

      t.monetize :price,
                  amount: { null: false, default: 0 },
                  currency: { null: false, default: Money.default_currency.iso_code }

      t.monetize :sale_price,
                  amount: { null: true, default: nil },
                  currency: { null: true, default: nil }

      t.datetime :sale_starts_at
      t.datetime :sale_ends_at
      t.datetime :available_from
      t.datetime :available_until

      t.belongs_to :business, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :products, %i[ business_id code ], unique: true, where: "code IS NOT NULL AND code <> ''"
    add_index :products, %i[ business_id slug ], unique: true
    add_index :products, %i[ business_id name ], unique: true

    add_check_constraint(
      :products,
      "visible IN (0, 1)",
      name: "check_products_visible_boolean"
    )

    add_check_constraint(
      :products,
      "featured IN (0, 1)",
      name: "check_products_featured_boolean"
    )

    add_check_constraint(
      :products,
      "code IS NULL OR length(code) <= 50",
      name: "check_products_code_length"
    )

    add_check_constraint(
      :products,
      "length(name) <= 150",
      name: "check_products_name_length"
    )

    add_check_constraint(
      :products,
      "description IS NULL OR length(description) <= 5000",
      name: "check_products_description_length"
    )

    add_check_constraint(
      :products,
      "price_cents >= 0",
      name: "check_products_price_nonnegative"
    )

    add_check_constraint(
      :products,
      "sale_price_cents IS NULL OR sale_price_cents >= 0",
      name: "check_products_sale_price_nonnegative"
    )

    add_check_constraint(
      :products,
      "sale_price_cents IS NULL OR sale_price_cents < price_cents",
      name: "check_products_sale_price_lt_price"
    )

    add_check_constraint(
      :products,
      "sale_starts_at IS NULL OR sale_ends_at IS NULL OR sale_starts_at < sale_ends_at",
      name: "check_products_sale_range"
    )

    add_check_constraint(
      :products,
      "available_from IS NULL OR available_until IS NULL OR available_from < available_until",
      name: "check_products_available_range"
    )

    reversible do |direction|
      direction.down do
        remove_check_constraint :products, name: "check_products_visible_boolean"
        remove_check_constraint :products, name: "check_products_featured_boolean"
        remove_check_constraint :products, name: "check_products_code_length"
        remove_check_constraint :products, name: "check_products_name_length"
        remove_check_constraint :products, name: "check_products_description_length"
        remove_check_constraint :products, name: "check_products_price_nonnegative"
        remove_check_constraint :products, name: "check_products_sale_price_nonnegative"
        remove_check_constraint :products, name: "check_products_sale_price_lt_price"
        remove_check_constraint :products, name: "check_products_sale_range"
        remove_check_constraint :products, name: "check_products_available_range"
      end
    end
  end
end
