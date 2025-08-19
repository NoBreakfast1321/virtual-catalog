class CreateOptionGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :option_groups do |t|
      t.integer :maximum_selections
      t.integer :minimum_selections, null: false, default: 1
      t.string :name, null: false, limit: 30
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :business, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :option_groups, %i[business_id name], unique: true
  end
end
