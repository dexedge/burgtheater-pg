class Author < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  has_many :writings
  has_many :works, through: :writings

  def self.my_import(file)
    authors = []
    CSV.foreach(file.path, headers: true) do |row|
      row[5] = Date.strptime(row[5], '%m/%d/%Y').to_datetime
      row[6] = Date.strptime(row[6], '%m/%d/%Y').to_datetime
      authors << Author.new(row.to_h)
    end
    Author.import authors, recursive: true
  end

  def next
    Author.order(:lastname).find_by("lastname > ?", lastname)
  end
  
  def prev
    Author.order(lastname: :desc).find_by("lastname < ?", lastname)
  end

  def authorName
    if self.firstnames
      self.lastname + ", " + self.firstnames
    else
      self.lastname
    end
  end
end