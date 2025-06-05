class CreateProductCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :product_categories do |t|
      t.references :product, null: false, foreign_key: { on_delete: :cascade }
      t.references :category, null: false, foreign_key: { on_delete: :restrict }

      t.timestamps
    end

    add_index :product_categories, %i[product_id category_id], unique: true
    add_index :product_categories, %i[category_id product_id]
  end
end
