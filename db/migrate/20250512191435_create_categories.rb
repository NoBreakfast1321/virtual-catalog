class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.boolean :visible, null: false, default: true
      t.string :name, null: false, limit: 30
      t.text :description, limit: 150
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :categories, %i[ user_id name ], unique: true

    add_check_constraint(
      :categories,
      "visible IN (0, 1)",
      name: "check_categories_visible_boolean"
    )

    add_check_constraint(
      :categories,
      "length(name) <= 30",
      name: "check_categories_name_length"
    )

    add_check_constraint(
      :categories,
      "description IS NULL OR length(description) <= 150",
      name: "check_categories_description_length"
    )

    reversible do |dir|
      dir.down do
        remove_check_constraint :categories, name: "check_categories_visible_boolean"
        remove_check_constraint :categories, name: "check_categories_name_length"
        remove_check_constraint :categories, name: "check_categories_description_length"
      end
    end
  end
end
