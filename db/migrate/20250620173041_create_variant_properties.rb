class CreateVariantProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :variant_properties do |t|
      # 1) Associations (FKs)
      t.belongs_to :variant, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :property, null: false, foreign_key: { on_delete: :cascade }

      # 2) Identifiers / business keys
      # (none here)

      # 3) Domain fields
      # (none here)

      # 4) State flags
      # (none here)

      # 5) Domain temporal attributes
      # (none here)

      t.timestamps
    end

    add_index :variant_properties, %i[variant_id property_id], unique: true
    add_index :variant_properties, %i[property_id variant_id]
  end
end
