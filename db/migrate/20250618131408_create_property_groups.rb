class CreatePropertyGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :property_groups do |t|
      t.string :name, null: false, limit: 30
      t.timestamps

      t.belongs_to :business, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :property_groups, %i[business_id name], unique: true
  end
end
