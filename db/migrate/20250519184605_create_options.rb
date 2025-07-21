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

    add_check_constraint(
      :options,
      "length(name) <= 50",
      name: "check_options_name_length",
    )

    add_check_constraint(
      :options,
      "price_cents >= 0",
      name: "check_options_price_nonnegative",
    )

    add_check_constraint(
      :options,
      "visible IN (0, 1)",
      name: "check_options_visible_boolean",
    )

    reversible do |direction|
      direction.down do
        remove_check_constraint :options, name: "check_options_name_length"
        remove_check_constraint :options,
                                name: "check_options_price_nonnegative"

        remove_check_constraint :options, name: "check_options_visible_boolean"
      end
    end
  end
end
