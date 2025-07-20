class CreateProductOptionGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :product_option_groups do |t|
      t.timestamps

      t.belongs_to :option_group,
                   null: false,
                   foreign_key: {
                     on_delete: :restrict
                   }

      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :product_option_groups,
              %i[product_id option_group_id],
              unique: true

    add_index :product_option_groups, %i[option_group_id product_id]
  end
end
