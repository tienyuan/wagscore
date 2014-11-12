class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :address, presence: true

  scope :publicly_viewable, -> { where(public: true) }
end