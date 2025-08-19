class CreateVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :variants do |t|
      t.boolean :base, null: false, default: false
      t.string :code, limit: 50

      t.monetize :price,
                 amount: {
                   null: false,
                   default: 0
                 },
                 currency: {
                   null: false,
                   default: Money.default_currency.iso_code
                 }

      t.string :signature
      t.integer :stock_quantity
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :variants,
              [ :product_id ],
              unique: true,
              where: "base = 1",
              name: "index_variants_on_product_id_and_base"

    add_index :variants, %i[product_id code], unique: true

    add_index :variants,
              %i[product_id signature],
              unique: true,
              where: "base = 0 AND signature IS NOT NULL"
  end
end
