class CreateOptionTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :option_types do |t|
      t.boolean :visible, null: false, default: true
      t.string :name, null: false, limit: 30
      t.integer :min_choices, null: false, default: 1
      t.integer :max_choices
      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end

    add_index :option_types, %i[ product_id name ], unique: true

    add_check_constraint(
      :option_types,
      "visible IN (0, 1)",
      name: "check_option_types_visible_boolean"
    )

    add_check_constraint(
      :option_types,
      "length(name) <= 30",
      name: "check_option_types_name_length"
    )

    add_check_constraint(
      :option_types,
      "min_choices >= 1",
      name: "check_option_types_min_choices_gte_1"
    )

    add_check_constraint(
      :option_types,
      "max_choices IS NULL OR max_choices >= min_choices",
      name: "check_option_types_max_choices_gte_min_choices"
    )

    reversible do |dir|
      dir.down do
        remove_check_constraint :option_types, name: "check_option_types_visible_boolean"
        remove_check_constraint :option_types, name: "check_option_types_name_length"
        remove_check_constraint :option_types, name: "check_option_types_min_choices_gte_1"
        remove_check_constraint :option_types, name: "check_option_types_max_choices_gte_min_choices"
      end
    end
  end
end
