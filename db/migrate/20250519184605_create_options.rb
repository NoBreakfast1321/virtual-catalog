class CreateOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :options do |t|
      t.boolean :visible, null: false, default: true
      t.string :name, null: false, limit: 50

      t.monetize :price_variation,
                  amount: { null: true, default: nil },
                  currency: { null: true, default: nil }

      t.belongs_to :option_group, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :options, %i[ option_group_id name ], unique: true

    add_check_constraint(
      :options,
      "visible IN (0, 1)",
      name: "check_options_visible_boolean"
    )

    add_check_constraint(
      :options,
      "length(name) <= 50",
      name: "check_options_name_length"
    )

    reversible do |direction|
      direction.down do
        remove_check_constraint :options, name: "check_options_visible_boolean"
        remove_check_constraint :options, name: "check_options_name_length"
      end
    end
  end
end
