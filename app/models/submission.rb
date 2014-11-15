class Submission < ActiveRecord::Base
  belongs_to :location

  validates :ip_address, presence: true
  validates :email, presence: true
end
