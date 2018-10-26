class Performance < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  belongs_to :event
  belongs_to :work
   
  def self.my_import(file)
    performances = []
    CSV.foreach(file.path, headers: true) do |row|
      performances << Performance.new(row.to_h)
    end
    Performance.import performances, recursive: true
  end
end
