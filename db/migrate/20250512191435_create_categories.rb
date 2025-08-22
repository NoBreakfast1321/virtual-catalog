class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      # 1) Associations (FKs)
      t.belongs_to :catalog, null: false, foreign_key: { on_delete: :cascade }

      # 2) Identifiers / business keys
      t.string :name, null: false, limit: 30

      # 3) Domain fields
      t.text :description, limit: 150

      # 4) State flags
      t.boolean :visible, null: false, default: true

      # 5) Domain temporal attributes
      # (none here)

      t.timestamps
    end

    add_index :categories, %i[catalog_id name], unique: true
  end
end
