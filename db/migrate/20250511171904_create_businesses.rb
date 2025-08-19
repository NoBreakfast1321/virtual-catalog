class CreateBusinesses < ActiveRecord::Migration[8.0]
  def change
    create_table :businesses do |t|
      t.text :description, limit: 150
      t.string :name, null: false, limit: 30
      t.string :slug, null: false, limit: 30
      t.boolean :visible, null: false, default: true
      t.timestamps

      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }
    end

    add_index :businesses, :slug, unique: true

    add_index :businesses, %i[user_id name], unique: true
  end
end
