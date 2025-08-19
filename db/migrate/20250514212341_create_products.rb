class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.boolean :adult_only, null: false, default: false
      t.datetime :available_from
      t.datetime :available_until
      t.string :code, limit: 50
      t.text :description, limit: 5000
      t.boolean :featured, null: false, default: false
      t.string :name, null: false, limit: 150
      t.string :slug, null: false, limit: 150
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :business, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :products, %i[business_id code], unique: true
    add_index :products, %i[business_id name], unique: true
    add_index :products, %i[business_id slug], unique: true
  end
end
