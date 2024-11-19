class AddCommentsCountToPosts < ActiveRecord::Migration[7.2]
  def up
    add_column :posts, :comments_count, :integer, default: 0, null: false
  end

  def down
    remove_column :posts, :comments_count
  end
end
