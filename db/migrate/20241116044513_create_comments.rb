class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :post, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
