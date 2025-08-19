class CreateOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :options do |t|
      t.string :name, null: false, limit: 50

      t.monetize :price,
                 amount: {
                   null: false,
                   default: 0
                 },
                 currency: {
                   null: false,
                   default: Money.default_currency.iso_code
                 }

      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :option_group,
                   null: false,
                   foreign_key: {
                     on_delete: :cascade
                   }
    end

    add_index :options, %i[option_group_id name], unique: true
  end
end
