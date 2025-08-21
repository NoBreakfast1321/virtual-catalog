class CreatePropertyGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :property_groups do |t|
      # 1) Associations (FKs)
      t.belongs_to :business, null: false, foreign_key: { on_delete: :cascade }

      # 2) Identifiers / business keys
      t.string :name, null: false, limit: 30

      # 3) Domain fields
      # (none here)

      # 4) State flags
      # (none here)

      # 5) Domain temporal attributes
      # (none here)

      t.timestamps
    end

    add_index :property_groups, %i[business_id name], unique: true
  end
end
