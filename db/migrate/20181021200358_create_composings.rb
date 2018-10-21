class CreateComposings < ActiveRecord::Migration[5.2]
  def change
    create_table :composings do |t|
      t.integer :composer_id
      t.integer :work_id
      t.timestamps
    end
    add_index :composings, [:composer_id, :work_id], unique: true
  end
end
