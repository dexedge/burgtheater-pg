class AddSortableNameToAuthor < ActiveRecord::Migration[5.2]
  # Based on code at https://railsguides.net/change-data-in-migrations-like-a-boss/
  
  def up
    add_column :authors, :sortable_name, :string
    Author.find_each do |author|
      author.sortable_name = author.lastname.downcase.sub(/ö/,"oe").sub(/ü/, "ue").sub(/ä/, "ae")
      author.save!
    end
  end

  def down
    remove_column :authors, :sortable_name
  end
end
