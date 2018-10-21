class CreateWritings < ActiveRecord::Migration[5.2]
  def change
    create_table :writings do |t|
      t.integer :author_id
      t.integer :work_id
      t.string :function
      t.timestamps
    end
  add_index :writings, [:author_id, :work_id], unique: true
  end
end
