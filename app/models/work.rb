class Work < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  has_many :performances
  has_many :events, through: :performances
  has_many :writings
  has_many :authors, through: :writings
  has_many :composings
  has_many :composers, through: :composings

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
    Work.order("lower(title)").find_by("title > ?", title)
  end
  
  def prev
    Work.order("lower(title) DESC").find_by("title < ?", title)
  end
end
