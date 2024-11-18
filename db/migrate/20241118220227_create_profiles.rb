class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles, id: false do |t|
      t.primary_key :user_id
      t.text :bio

      t.timestamps
    end

    add_foreign_key :profiles, :users, column: :user_id
  end
end
