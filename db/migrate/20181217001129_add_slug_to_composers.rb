class AddSlugToComposers < ActiveRecord::Migration[5.2]
  def change
    add_column :composers, :slug, :string
    add_index :composers, :slug, unique: true
  end
end
