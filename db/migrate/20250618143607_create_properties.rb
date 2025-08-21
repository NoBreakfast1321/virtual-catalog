class CreateProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :properties do |t|
      # 1) Associations (FKs)
      t.belongs_to :property_group,
                   null: false,
                   foreign_key: {
                     on_delete: :cascade
                   }

      # 2) Identifiers / business keys
      t.string :name, null: false, limit: 50

      # 3) Domain fields
      # (none here)

      # 4) State flags
      # (none here)

      # 5) Domain temporal attributes
      # (none here)

      t.timestamps
    end

    add_index :properties, %i[property_group_id name], unique: true
  end
end
