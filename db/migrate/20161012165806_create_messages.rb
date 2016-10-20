class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages, id: false do |t|
      t.string :link, null: false
      t.string :body
      t.integer :views_count
      t.integer :visits_limit
      t.float :exist_hours

      t.timestamps null: false
    end

    add_index :messages, :link, unique: true
  end
end
