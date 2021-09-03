class Road < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :start_latitude, presence: true
  validates :start_longitude, presence: true
  validates :goal_latitude, presence: true
  validates :goal_longitude, presence: true
  validates :distance, presence: true
  validates :elevation_gain, presence: true
  validates :difficulty, presence: true

  #ActiveStorageを使用
  has_one_attached :image

  has_many :check_points



  enum difficulty: { easy: 0, normal: 1, hard: 2 }
end
