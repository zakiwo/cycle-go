class Waypoint < ApplicationRecord
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :point_no, presence: true

  belongs_to :road
  belongs_to :user
end
