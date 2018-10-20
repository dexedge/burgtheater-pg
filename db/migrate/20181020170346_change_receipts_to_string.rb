# Based on: https://tosbourn.com/rails-migrate-change-column-type/

class ChangeReceiptsToString < ActiveRecord::Migration[5.2]
  def up
    change_column :events, :receipts, :string
  end

  def down
    change_column :events, :receipts, :string
  end
end
