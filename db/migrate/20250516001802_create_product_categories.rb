class CreateProductCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :product_categories do |t|
      # 1) Associations (FKs)
      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }
      t.belongs_to :category, null: false, foreign_key: { on_delete: :restrict }

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

    add_index :product_categories, %i[product_id category_id], unique: true
    add_index :product_categories, %i[category_id product_id]
  end
end
