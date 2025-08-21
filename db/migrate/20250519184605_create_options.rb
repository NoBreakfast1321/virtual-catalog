class CreateOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :options do |t|
      # 1) Associations (FKs)
      t.belongs_to :option_group,
                   null: false,
                   foreign_key: {
                     on_delete: :cascade
                   }

      # 2) Identifiers / business keys
      t.string :name, null: false, limit: 50

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

      # 4) State flags
      t.boolean :visible, null: false, default: true

      # 5) Domain temporal attributes
      # (none here)

      t.timestamps
    end

    add_index :options, %i[option_group_id name], unique: true
  end
end
