class CreateOptionGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :option_groups do |t|
      t.integer     :max_choices
      t.integer     :min_choices, null: false, default: 1
      t.string      :name, null: false, limit: 30
      t.boolean     :visible, null: false, default: true
      t.timestamps

      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :option_groups, %i[ product_id name ], unique: true

    add_check_constraint(
      :option_groups,
      "max_choices IS NULL OR max_choices >= min_choices",
      name: "check_option_groups_max_choices_gte_min_choices"
    )

    add_check_constraint(
      :option_groups,
      "min_choices >= 1",
      name: "check_option_groups_min_choices_gte_1"
    )

    add_check_constraint(
      :option_groups,
      "length(name) <= 30",
      name: "check_option_groups_name_length"
    )

    add_check_constraint(
      :option_groups,
      "visible IN (0, 1)",
      name: "check_option_groups_visible_boolean"
    )

    reversible do |direction|
      direction.down do
        remove_check_constraint :option_groups, name: "check_option_groups_max_choices_gte_min_choices"
        remove_check_constraint :option_groups, name: "check_option_groups_min_choices_gte_1"
        remove_check_constraint :option_groups, name: "check_option_groups_name_length"
        remove_check_constraint :option_groups, name: "check_option_groups_visible_boolean"
      end
    end
  end
end
