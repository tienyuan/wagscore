class Location < ActiveRecord::Base
  validates :name, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  scope :publicly_viewable, -> { where(public: true) }
end