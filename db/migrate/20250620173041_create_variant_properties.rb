class CreateVariantProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :variant_properties do |t|
      t.integer :position, null: false
      t.timestamps

      t.belongs_to :property, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :variant, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :variant_properties, %i[ property_id variant_id ]
    add_index :variant_properties, %i[ variant_id property_id ], unique: true
  end
end
