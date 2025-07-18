class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.boolean :adult_only, null: false, default: false
      t.datetime :available_from
      t.datetime :available_until
      t.string :code, limit: 50
      t.text :description, limit: 5000
      t.boolean :featured, null: false, default: false
      t.string :name, null: false, limit: 150

      t.monetize :price,
                 amount: {
                   null: false,
                   default: 0
                 },
                 currency: {
                   null: false,
                   default: Money.default_currency.iso_code
                 }

      t.string :slug, null: false, limit: 150
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :business, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :products,
              %i[business_id code],
              unique: true,
              where: "code IS NOT NULL AND code <> ''"

    add_index :products, %i[business_id name], unique: true
    add_index :products, %i[business_id slug], unique: true

    add_check_constraint(
      :products,
      "adult_only IN (0, 1)",
      name: "check_products_adult_only_boolean",
    )

    add_check_constraint(
      :products,
      "available_from IS NULL OR available_until IS NULL OR available_from < available_until",
      name: "check_products_available_range",
    )

    add_check_constraint(
      :products,
      "code IS NULL OR length(code) <= 50",
      name: "check_products_code_length",
    )

    add_check_constraint(
      :products,
      "description IS NULL OR length(description) <= 5000",
      name: "check_products_description_length",
    )

    add_check_constraint(
      :products,
      "featured IN (0, 1)",
      name: "check_products_featured_boolean",
    )

    add_check_constraint(
      :products,
      "length(name) <= 150",
      name: "check_products_name_length",
    )

    add_check_constraint(
      :products,
      "price_cents >= 0",
      name: "check_products_price_nonnegative",
    )

    add_check_constraint(
      :products,
      "visible IN (0, 1)",
      name: "check_products_visible_boolean",
    )

    reversible do |direction|
      direction.down do
        remove_check_constraint :products,
                                name: "check_products_adult_only_boolean"

        remove_check_constraint :products,
                                name: "check_products_available_range"

        remove_check_constraint :products, name: "check_products_code_length"

        remove_check_constraint :products,
                                name: "check_products_description_length"

        remove_check_constraint :products,
                                name: "check_products_featured_boolean"

        remove_check_constraint :products, name: "check_products_name_length"

        remove_check_constraint :products,
                                name: "check_products_price_nonnegative"

        remove_check_constraint :products,
                                name: "check_products_visible_boolean"
      end
    end
  end
end
