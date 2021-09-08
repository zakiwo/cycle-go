class CheckPointComment < ApplicationRecord
  validates :body, presence: true
  
  belongs_to :road
  belongs_to :check_point
  belongs_to :user
end
