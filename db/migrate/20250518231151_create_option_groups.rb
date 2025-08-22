class CreateOptionGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :option_groups do |t|
      # 1) Associations (FKs)
      t.belongs_to :catalog, null: false, foreign_key: { on_delete: :cascade }

      # 2) Identifiers / business keys
      t.string :name, null: false, limit: 30

      # 3) Domain fields
      t.integer :minimum_selections, null: false, default: 1
      t.integer :maximum_selections

      # 4) State flags
      t.boolean :visible, null: false, default: true

      # 5) Domain temporal attributes
      # (none here)

      t.timestamps
    end

    add_index :option_groups, %i[catalog_id name], unique: true
  end
end
