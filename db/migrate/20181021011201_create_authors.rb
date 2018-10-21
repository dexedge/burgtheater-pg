class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors, id: false, timestamps: false do |t|
      t.primary_key :id
      t.string :lastname
      t.string :firstnames
      t.integer :birth
      t.integer :death
      t.datetime :created_at
      t.datetime :updated_at

    end
  end
end
