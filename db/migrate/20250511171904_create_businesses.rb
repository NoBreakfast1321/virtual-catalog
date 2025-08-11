class CreateBusinesses < ActiveRecord::Migration[8.0]
  def change
    create_table :businesses do |t|
      t.text :description, limit: 150
      t.string :name, null: false, limit: 30
      t.string :slug, null: false, limit: 30
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }

      t.check_constraint(
        "length(description) <= 150",
        name: "check_businesses_description_length",
      )

      t.check_constraint(
        "length(name) <= 30",
        name: "check_businesses_name_length",
      )

      t.check_constraint(
        "length(slug) <= 30",
        name: "check_businesses_slug_length",
      )

      t.check_constraint(
        "slug GLOB '[a-z0-9_-]*'",
        name: "check_businesses_slug_format",
      )

      t.check_constraint(
        "visible IN (0, 1)",
        name: "check_businesses_visible_boolean",
      )
    end

    add_index :businesses, :slug, unique: true
    add_index :businesses, %i[user_id name], unique: true
  end
end
