class CreateProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :properties do |t|
      t.string :name, null: false, limit: 50
      t.timestamps

      t.belongs_to :property_group,
                   null: false,
                   foreign_key: {
                     on_delete: :cascade
                   }
    end

    add_index :properties, %i[property_group_id name], unique: true
  end
end
