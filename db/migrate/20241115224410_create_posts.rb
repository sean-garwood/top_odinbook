class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.text :body
      t.integer :likes
      t.text :title

      t.timestamps
    end
  end
end
