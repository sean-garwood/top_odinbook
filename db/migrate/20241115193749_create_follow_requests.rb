class CreateFollowRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :follow_requests do |t|
      t.references :leader, null: false, foreign_key: { to_table: :users }
      t.references :follower, null: false, foreign_key: { to_table: :users }
      # add a status column to track the state of the follow request
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
