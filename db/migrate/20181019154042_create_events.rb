# id: false and timestamps: false so that Rails doesn't automatically create these. Then use the syntax below for :id, :created_at, and :updated_at. Note that :updated_at will not preserve the updated date from the CSV file, but will treat the import of the records as an update and give the datetime of the import.

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events, id: false, timestamps: false do |t|
      t.primary_key :id
      t.date :date
      t.integer :receipts
      t.string :kind
      t.boolean :zinzendorf
      t.boolean :double
      t.text :notes
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
