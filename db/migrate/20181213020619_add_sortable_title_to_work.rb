class AddSortableTitleToWork < ActiveRecord::Migration[5.2]
  def up
    add_column :works, :sortable_title, :string
    Work.find_each do |work|
      work.sortable_title = work.title.downcase.sub(/^(das|der|die|i|il|la|le|una)\s|l'/, "").sub(/ä/,"ae").sub(/ö/,"oe").sub(/ü/,"ue")
      work.save!
    end
  end

  def down
    remove_column :works, :sortable_title
  end
end
