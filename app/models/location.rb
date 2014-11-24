class Location < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_one :submission, dependent: :destroy
  accepts_nested_attributes_for :submission

  validates :name, presence: true
  validates :address, presence: true

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
    if (include_private if include_private.present?) && search_term.present?
      Location.near(search_term, distance_term || Location.default_search_distance)
    elsif (include_private if include_private.present?)
      Location.all
    elsif search_term.present?
      Location.near(search_term, distance_term || Location.default_search_distance).publicly_viewable
    else
      Location.all.publicly_viewable
    end
  end
end