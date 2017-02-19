class CreateBlockades < ActiveRecord::Migration[5.0]
  def change
    create_table :blockades do |t|

      t.timestamps
    end
  end
end
