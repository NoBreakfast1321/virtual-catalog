class CreateLineItems < ActiveRecord::Migration[8.0]
  def change
    create_table :line_items do |t|
      # 1) Associations (FKs)
      t.belongs_to :variant, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :customer, foreign_key: { on_delete: :cascade }

      # 2) Identifiers / business keys
      # (none here)

      # 3) Domain fields
      t.integer :quantity, null: false, default: 1

      # 4) State flags
      # (none here)

      # 5) Domain temporal attributes
      # (none here)

      t.timestamps
    end

    add_index :line_items, %i[customer_id variant_id], unique: true
  end
end
