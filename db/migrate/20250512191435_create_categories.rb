class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.text :description, limit: 150
      t.string :name, null: false, limit: 30
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :business, null: false, foreign_key: { on_delete: :cascade }

      t.check_constraint(
        "length(description) <= 150",
        name: "check_categories_description_length",
      )

      t.check_constraint(
        "length(name) <= 30",
        name: "check_categories_name_length",
      )

      t.check_constraint(
        "visible IN (0, 1)",
        name: "check_categories_visible_boolean",
      )
    end

    add_index :categories, %i[business_id name], unique: true
  end
end
