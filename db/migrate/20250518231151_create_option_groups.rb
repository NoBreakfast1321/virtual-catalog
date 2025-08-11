class CreateOptionGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :option_groups do |t|
      t.integer :maximum_selections
      t.integer :minimum_selections, null: false, default: 1
      t.string :name, null: false, limit: 30
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :business, null: false, foreign_key: { on_delete: :cascade }

      t.check_constraint(
        "maximum_selections >= minimum_selections",
        name: "check_option_groups_maximum_selections_gte_minimum_selections",
      )

      t.check_constraint(
        "minimum_selections >= 1",
        name: "check_option_groups_minimum_selections_gte_1",
      )

      t.check_constraint(
        "length(name) <= 30",
        name: "check_option_groups_name_length",
      )

      t.check_constraint(
        "visible IN (0, 1)",
        name: "check_option_groups_visible_boolean",
      )
    end

    add_index :option_groups, %i[business_id name], unique: true
  end
end
