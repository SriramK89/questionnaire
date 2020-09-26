class Question < ApplicationRecord
  validates_presence_of :content

  belongs_to :role
  belongs_to :mapping
end
