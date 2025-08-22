class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      # 1) Associations (FKs)
      t.belongs_to :catalog, null: false, foreign_key: { on_delete: :cascade }

      # 2) Identifiers / business keys
      t.string :name, null: false, limit: 150
      t.string :slug, null: false, limit: 150
      t.string :code, limit: 50

      # 3) Domain fields
      t.text :description, limit: 5000

      # 4) State flags
      t.boolean :adult_only, null: false, default: false
      t.boolean :featured, null: false, default: false
      t.boolean :visible, null: false, default: true

      # 5) Domain temporal attributes
      t.datetime :available_from
      t.datetime :available_until

      t.timestamps
    end

    add_index :products, %i[catalog_id name], unique: true
    add_index :products, %i[catalog_id slug], unique: true
    add_index :products, %i[catalog_id code], unique: true
  end
end
