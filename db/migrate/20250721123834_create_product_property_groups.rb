class CreateProductPropertyGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :product_property_groups do |t|
      t.timestamps

      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }

      t.belongs_to :property_group,
                   null: false,
                   foreign_key: {
                     on_delete: :restrict
                   }
    end

    add_index :product_property_groups,
              %i[product_id property_group_id],
              unique: true

    add_index :product_property_groups, %i[property_group_id product_id]
  end
end
