class CreateVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :variants do |t|
      t.string      :code, limit: 50

      t.monetize    :price_override,
                      amount: { null: true, default: nil },
                      currency: { null: true, default: nil }

      t.timestamps

      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }
    end

    add_check_constraint(
      :variants,
      "code IS NULL OR length(code) <= 50",
      name: "check_variants_code_length"
    )

    add_check_constraint(
      :variants,
      "price_override_cents IS NULL OR price_override_cents >= 0",
      name: "check_variants_price_override_nonnegative"
    )

    reversible do |direction|
      direction.down do
        remove_check_constraint :variants, name: "check_variants_code_length"
        remove_check_constraint :variants, name: "check_variants_price_override_nonnegative"
      end
    end
  end
end
