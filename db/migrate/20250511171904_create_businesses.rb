class CreateBusinesses < ActiveRecord::Migration[8.0]
  def change
    create_table :businesses do |t|
      t.boolean :visible, null: false, default: true
      t.string :name, null: false, limit: 30
      t.text :description, limit: 150

      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_check_constraint(
      :businesses,
      "visible IN (0, 1)",
      name: "check_businesses_visible_boolean"
    )

    add_check_constraint(
      :businesses,
      "length(name) <= 30",
      name: "check_businesses_name_length"
    )

    add_check_constraint(
      :businesses,
      "description IS NULL OR length(description) <= 150",
      name: "check_businesses_description_length"
    )

    reversible do |dir|
      dir.down do
        remove_check_constraint :businesses, name: "check_businesses_visible_boolean"
        remove_check_constraint :businesses, name: "check_businesses_name_length"
        remove_check_constraint :businesses, name: "check_businesses_description_length"
      end
    end
  end
end
