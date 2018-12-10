class AddCreditedAuthorToWritings < ActiveRecord::Migration[5.2]
  def change
    add_column :writings, :credited_author, :boolean
  end
end
