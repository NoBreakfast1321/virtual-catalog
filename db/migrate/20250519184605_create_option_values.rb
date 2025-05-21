class CreateOptionValues < ActiveRecord::Migration[8.0]
  def change
    create_table :option_values do |t|
      t.boolean :visible, null: false, default: true
      t.string :name, null: false, limit: 50

      t.monetize :price_variation,
                  amount: { null: true, default: nil },
                  currency: { null: true, default: Money.default_currency.iso_code }

      t.belongs_to :option_type, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end

    add_index :option_values, %i[ option_type_id name ], unique: true

    add_check_constraint(
      :option_values,
      "visible IN (0, 1)",
      name: "check_option_values_visible_boolean"
    )

    add_check_constraint(
      :option_values,
      "length(name) <= 50",
      name: "check_option_values_name_length"
    )

    reversible do |dir|
      dir.down do
        remove_check_constraint :option_values, name: "check_option_values_visible_boolean"
        remove_check_constraint :option_values, name: "check_option_values_name_length"
      end
    end
  end
end
