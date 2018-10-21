class Work < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/sqlite3_adapter'

  has_many :performances
  has_many :events, through: :performances
  has_many :writings
  has_many :authors, through: :writings

  def self.my_import(file)
    works = []
    CSV.foreach(file.path, headers: true) do |row|
      row[4] = Date.strptime(row[4], '%m/%d/%Y').to_datetime
      row[5] = Date.strptime(row[5], '%m/%d/%Y').to_datetime
      works << Work.new(row.to_h)
    end
    Work.import works, recursive: true
  end
  
  def next
    Work.where("id > ?", id).first
  end
  
  def prev
    Work.where("id < ?", id).last
  end
end
