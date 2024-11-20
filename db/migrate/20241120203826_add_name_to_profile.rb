class AddNameToProfile < ActiveRecord::Migration[7.2]
  def change
    add_column :profiles, :name, :string
  end
end
