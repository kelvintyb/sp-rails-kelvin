class CreateBlockades < ActiveRecord::Migration[5.0]
  def change
    create_table :blockades do |t|
      t.references :blocked, index: true
      t.references :blocker, index: true

      t.timestamps
    end
    add_index :blockades, [:blocker_id, :blocked_id], unique: true
  end
end
