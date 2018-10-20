class CreatePerformances < ActiveRecord::Migration[5.2]
  def change
    create_table :performances do |t|
      t.integer :event_id
      t.integer :work_id
      t.timestamps
    end
    add_index :performances, [:event_id, :work_id], unique: true
  end
end
