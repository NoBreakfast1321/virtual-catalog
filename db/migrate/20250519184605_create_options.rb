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

      t.check_constraint(
        "length(name) <= 50",
        name: "check_options_name_length",
      )

      t.check_constraint(
        "price_cents >= 0",
        name: "check_options_price_cents_nonnegative",
      )

      t.check_constraint(
        "visible IN (0, 1)",
        name: "check_options_visible_boolean",
      )
    end

    add_index :options, %i[option_group_id name], unique: true
  end
end
