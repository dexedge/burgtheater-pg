class Work < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'
  extend FriendlyId

  has_many :performances
  has_many :events, through: :performances
  has_many :writings
  has_many :authors, through: :writings
  has_many :composings
  has_many :composers, through: :composings

  friendly_id :title, use: :slugged

  def self.my_import(file)
    works = []
    CSV.foreach(file.path, headers: true) do |row|
      row[4] = Date.strptime(row[4], '%m/%d/%Y').to_datetime
      row[5] = Date.strptime(row[5], '%m/%d/%Y').to_datetime
      works << Work.new(row.to_h)
    end
    Work.import works, recursive: true
  end
  
  # def next
  #   Work.order(:sortable_title).find_by("sortable_title > ?", sortable_title)
  # end
  
  # def prev
  #   Work.order(sortable_title: :desc).find_by("sortable_title < ?", sortable_title)
  # end

  def is_author?(author)
    self.authors.include?(author)
  end

  def should_generate_new_friendly_id?
    title_changed?
  end
end
