class CreateVariants < ActiveRecord::Migration[8.0]
  def change
    create_table :variants do |t|
      # 1) Associations (FKs)
      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }

      # 2) Identifiers / business keys
      t.string :code, limit: 50
      t.string :property_combination

      # 3) Domain fields
      t.monetize :price,
                 amount: {
                   null: false,
                   default: 0
                 },
                 currency: {
                   null: false,
                   default: Money.default_currency.iso_code
                 }

      t.integer :stock_quantity

      # 4) State flags
      t.boolean :base, null: false, default: false
      t.boolean :visible, null: false, default: true

      # 5) Domain temporal attributes
      # (none here)

      t.timestamps
    end

    add_index :variants,
              [ :product_id ],
              unique: true,
              where: "base = 1",
              name: "index_variants_on_product_id_and_base"

    add_index :variants, %i[product_id code], unique: true

    add_index :variants,
              %i[product_id property_combination],
              unique: true,
              where: "base = 0 AND property_combination IS NOT NULL"
  end
end
