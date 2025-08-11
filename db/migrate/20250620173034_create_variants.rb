class CreateVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :variants do |t|
      t.boolean :base, null: false, default: false
      t.string :code, limit: 50

      t.monetize :price,
                 amount: {
                   null: false,
                   default: 0
                 },
                 currency: {
                   null: false,
                   default: Money.default_currency.iso_code
                 }

      t.string :signature
      t.integer :stock_quantity
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }

      t.check_constraint("base IN (0, 1)", name: "check_variants_base_boolean")

      t.check_constraint(
        "base = 1 OR NULLIF(TRIM(signature), '') IS NOT NULL",
        name: "check_variants_signature_present_when_non_base",
      )

      t.check_constraint(
        "length(code) <= 50",
        name: "check_variants_code_length",
      )

      t.check_constraint(
        "price_cents >= 0",
        name: "check_variants_price_cents_nonnegative",
      )

      t.check_constraint(
        "stock_quantity >= 0",
        name: "check_variants_stock_quantity_nonnegative",
      )

      t.check_constraint(
        "visible IN (0, 1)",
        name: "check_variants_visible_boolean",
      )
    end

    add_index :variants, [ :product_id ], unique: true, where: "base = 1"

    add_index :variants,
              %i[product_id code],
              unique: true,
              where: "NULLIF(TRIM(code), '') IS NOT NULL"

    add_index :variants,
              %i[product_id signature],
              unique: true,
              where: "base = 0 AND NULLIF(TRIM(signature), '') IS NOT NULL"
  end
end
