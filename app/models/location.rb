class Location < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_one :submission, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true

  geocoded_by :full_address
  after_validation :geocode if :address.present? && :address_changed?

  scope :publicly_viewable, -> { where(public: true) }

  def full_address
    [address, city, state, zipcode].compact.join(', ')
  end
end