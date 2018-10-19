class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works, id: false, timestamps: false do |t|
      t.primary_key :id
      t.string :title
      t.string :genre
      t.text :notes
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
