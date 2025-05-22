class CreateOptionGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :option_groups do |t|
      t.boolean :visible, null: false, default: true
      t.string :name, null: false, limit: 30
      t.integer :min_choices, null: false, default: 1
      t.integer :max_choices
      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end

    add_index :option_groups, %i[ product_id name ], unique: true

    add_check_constraint(
      :option_groups,
      "visible IN (0, 1)",
      name: "check_option_groups_visible_boolean"
    )

    add_check_constraint(
      :option_groups,
      "length(name) <= 30",
      name: "check_option_groups_name_length"
    )

    add_check_constraint(
      :option_groups,
      "min_choices >= 1",
      name: "check_option_groups_min_choices_gte_1"
    )

    add_check_constraint(
      :option_groups,
      "max_choices IS NULL OR max_choices >= min_choices",
      name: "check_option_groups_max_choices_gte_min_choices"
    )

    reversible do |dir|
      dir.down do
        remove_check_constraint :option_groups, name: "check_option_groups_visible_boolean"
        remove_check_constraint :option_groups, name: "check_option_groups_name_length"
        remove_check_constraint :option_groups, name: "check_option_groups_min_choices_gte_1"
        remove_check_constraint :option_groups, name: "check_option_groups_max_choices_gte_min_choices"
      end
    end
  end
end
