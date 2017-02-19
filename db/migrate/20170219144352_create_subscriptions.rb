class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :subscriber, index: true
      t.references :subscribed, index: true

      t.timestamps
    end
    add_index :subscriptions, [:subscriber_id, :subscribed_id], unique: true
  end
end
