class RoadComment < ApplicationRecord
  validates :body, presence: true

  belongs_to :road
  belongs_to :user
end
