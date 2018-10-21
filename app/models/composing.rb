class Composing < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/sqlite3_adapter'

  belongs_to :composer
  belongs_to :work
  
  def self.my_import(file)
    composings = []
    CSV.foreach(file.path, headers: true) do |row|
      composings << Composing.new(row.to_h)
    end
    Composing.import composings, recursive: true
  end
end
