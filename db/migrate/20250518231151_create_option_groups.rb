class CreateOptionGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :option_groups do |t|
      t.integer :maximum_selections
      t.integer :minimum_selections, null: false, default: 1
      t.string :name, null: false, limit: 30
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :business, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :option_groups, %i[business_id name], unique: true

    add_check_constraint(
      :option_groups,
      "maximum_selections >= minimum_selections",
      name: "check_option_groups_maximum_selections_gte_minimum_selections",
    )

    add_check_constraint(
      :option_groups,
      "minimum_selections >= 1",
      name: "check_option_groups_minimum_selections_gte_1",
    )

    add_check_constraint(
      :option_groups,
      "length(name) <= 30",
      name: "check_option_groups_name_length",
    )

    add_check_constraint(
      :option_groups,
      "visible IN (0, 1)",
      name: "check_option_groups_visible_boolean",
    )

    reversible do |direction|
      direction.down do
        remove_check_constraint :option_groups,
                                name:
                                  "check_option_groups_maximum_selections_gte_minimum_selections"

        remove_check_constraint :option_groups,
                                name:
                                  "check_option_groups_minimum_selections_gte_1"

        remove_check_constraint :option_groups,
                                name: "check_option_groups_name_length"

        remove_check_constraint :option_groups,
                                name: "check_option_groups_visible_boolean"
      end
    end
  end
end
