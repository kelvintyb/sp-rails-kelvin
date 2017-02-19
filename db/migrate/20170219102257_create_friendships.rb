class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
        t.references :user, index: true, foreign_key: true
        t.references :friend_user, index: true

        t.timestamps
    end
      add_foreign_key :friendships, :users, column: :friend_user_id
      add_index(:friendships, [:user_id, :friend_user_id], :unique => true)
      add_index(:friendships, [:friend_user_id, :user_id], :unique => true)
  end
end
