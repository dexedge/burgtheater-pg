class Writing < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  belongs_to :author
  belongs_to :work

  def self.my_import(file)
    writings = []
    CSV.foreach(file.path, headers: true) do |row|
      writings << Writing.new(row.to_h)
    end
    Writing.import writings, recursive: true
  end
end
