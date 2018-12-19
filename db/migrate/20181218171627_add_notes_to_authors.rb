class AddNotesToAuthors < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :notes, :text
  end
end
