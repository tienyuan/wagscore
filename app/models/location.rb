class Location < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_one :submission, dependent: :destroy
  accepts_nested_attributes_for :submission

  validates :name, presence: true
  validates :address, presence: true
  #validates :categories, presence: true

  geocoded_by :full_address
  after_validation :geocode if :address.present? && :address_changed?

  scope :publicly_viewable, -> { where(public: true) }

  def full_address
    [address, city, state, zipcode].compact.join(', ')
  end

  def self.default_search_distance
    10 #miles
  end

  def self.search(search_term: nil, distance_term: nil, include_private: nil)
     if search_term.present?
      distance_in_miles = distance_term || Location.default_search_distance
      results = near(search_term, distance_in_miles)
    else
      results = all
    end

    if !include_private
      results = results.publicly_viewable
    end

    results
  end
end