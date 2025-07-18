class CreateOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :options do |t|
      t.string :name, null: false, limit: 50
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

    reversible do |direction|
      direction.down do
        remove_check_constraint :options, name: "check_options_name_length"
      end
    end
  end
end
