class AddLikesCountToPosts < ActiveRecord::Migration[7.2]
  def up
    add_column :posts, :likes_count, :integer, default: 0, null: false
  end

  def down
    remove_column :posts, :likes_count
  end
end
