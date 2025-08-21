class CreateProductOptionGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :product_option_groups do |t|
      # 1) Associations (FKs)
      t.belongs_to :product, null: false, foreign_key: { on_delete: :cascade }

      t.belongs_to :option_group,
                   null: false,
                   foreign_key: {
                     on_delete: :restrict
                   }

      # 2) Identifiers / business keys
      # (none here)

      # 3) Domain fields
      # (none here)

      # 4) State flags
      # (none here)

      # 5) Domain temporal attributes
      # (none here)

      t.timestamps
    end

    add_index :product_option_groups,
              %i[product_id option_group_id],
              unique: true

    add_index :product_option_groups, %i[option_group_id product_id]
  end
end
