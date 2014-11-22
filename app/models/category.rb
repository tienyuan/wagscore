class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :locations, through: :categorizations

  validates :name, presence: true, uniqueness: true

  scope :sort_asc, -> { order('name ASC') }
end
