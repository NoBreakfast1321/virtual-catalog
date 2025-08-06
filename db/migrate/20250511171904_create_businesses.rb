class CreateBusinesses < ActiveRecord::Migration[8.0]
  def change
    create_table :businesses do |t|
      t.text :description, limit: 150
      t.string :name, null: false, limit: 30
      t.string :slug, null: false, limit: 30
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :businesses, :slug, unique: true

    add_index :businesses, %i[user_id name], unique: true

    add_check_constraint(
      :businesses,
      "length(description) <= 150",
      name: "check_businesses_description_length",
    )

    add_check_constraint(
      :businesses,
      "length(name) <= 30",
      name: "check_businesses_name_length",
    )

    add_check_constraint(
      :businesses,
      "length(slug) <= 30",
      name: "check_businesses_slug_length",
    )

    add_check_constraint(
      :businesses,
      "slug GLOB '[a-z0-9_-]*'",
      name: "check_businesses_slug_format",
    )

    add_check_constraint(
      :businesses,
      "visible IN (0, 1)",
      name: "check_businesses_visible_boolean",
    )

    reversible do |direction|
      direction.down do
        remove_check_constraint :businesses,
                                name: "check_businesses_description_length"

        remove_check_constraint :businesses,
                                name: "check_businesses_name_length"

        remove_check_constraint :businesses,
                                name: "check_businesses_slug_length"

        remove_check_constraint :businesses,
                                name: "check_businesses_slug_format"

        remove_check_constraint :businesses,
                                name: "check_businesses_visible_boolean"
      end
    end
  end
end
