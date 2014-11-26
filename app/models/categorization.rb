class Categorization < ActiveRecord::Base
  belongs_to :category
  belongs_to :location

  validates :category, presence: true
  validates :location, presence: true
end
