class Waypoint < ApplicationRecord
  validates :name, presence: true
  validates :latitude, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  validates :longitude, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  validates :point_no, presence: true

  belongs_to :road
  belongs_to :user
end
