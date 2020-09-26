class Mapping < ApplicationRecord
  extend CSVImport

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :questions
end
