class RemoveLikesFromPost < ActiveRecord::Migration[7.2]
  def up
    remove_column :posts, :likes, :integer
  end

  def down
    add_column :posts, :likes, :integer
  end
end
