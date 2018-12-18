class AddImageNameToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :image_name, :text
    add_column :works, :book_url, :text
  end
end
