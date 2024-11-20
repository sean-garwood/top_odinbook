class CreateFollowRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :follow_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
