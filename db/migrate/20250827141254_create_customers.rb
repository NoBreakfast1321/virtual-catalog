class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      # 1) Associations (FKs)
      t.belongs_to :catalog, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :user, foreign_key: { on_delete: :nullify }

      # 2) Identifiers / business keys
      t.string :token, null: false, limit: 36 # UUIDv7
      t.string :email
      t.string :phone, limit: 16 # E.164 format

      # 3) Domain fields
      t.string :name, limit: 150

      # 4) State flags
      # (none here)

      # 5) Domain temporal attributes
      # (none here)

      t.timestamps
    end

    add_index :customers, %i[catalog_id user_id], unique: true
    add_index :customers, %i[catalog_id token], unique: true
    add_index :customers, %i[catalog_id email], unique: true
    add_index :customers, %i[catalog_id phone], unique: true
  end
end
