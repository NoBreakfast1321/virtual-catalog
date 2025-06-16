class CreateProductCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :product_categories do |t|
      t.timestamps

      t.belongs_to :category, null: false, foreign_key: { on_delete: :restrict }
      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :product_categories, %i[category_id product_id]
    add_index :product_categories, %i[product_id category_id], unique: true
  end
end
