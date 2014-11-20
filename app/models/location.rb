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

  def self.search_and_show(search_term = nil, distance_term = nil, admin_view = nil)
    if (admin_view if admin_view.present?) && search_term.present?
      Location.near(search_term, distance_term || 10)
    elsif (admin_view if admin_view.present?)
      Location.all
    elsif search_term.present?
      Location.near(search_term, distance_term || 10).publicly_viewable
    else
      Location.all.publicly_viewable
    end
  end
end