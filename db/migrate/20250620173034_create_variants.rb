class CreateVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :variants do |t|
      t.boolean     :base, null: false, default: false
      t.string      :code, limit: 50

      t.monetize    :price,
                      amount: { null: false, default: 0 },
                      currency: { null: false, default: Money.default_currency.iso_code }

      t.boolean     :visible, null: false, default: true
      t.timestamps

      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :variants, %i[ product_id code ], unique: true, where: "code IS NOT NULL AND code <> ''"

    add_check_constraint(
      :variants,
      "base IN (0, 1)",
      name: "check_variants_base_boolean"
    )

    add_check_constraint(
      :variants,
      "code IS NULL OR length(code) <= 50",
      name: "check_variants_code_length"
    )

    add_check_constraint(
      :variants,
      "price_cents >= 0",
      name: "check_variants_price_nonnegative"
    )

    add_check_constraint(
      :variants,
      "visible IN (0, 1)",
      name: "check_variants_visible_boolean"
    )

    reversible do |direction|
      direction.down do
        remove_check_constraint :variants, name: "check_variants_base_boolean"
        remove_check_constraint :variants, name: "check_variants_code_length"
        remove_check_constraint :variants, name: "check_variants_price_nonnegative"
        remove_check_constraint :variants, name: "check_variants_visible_boolean"
      end
    end
  end
end
