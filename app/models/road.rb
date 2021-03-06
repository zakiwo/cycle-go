class Road < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :start_latitude, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  validates :start_longitude, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  validates :goal_latitude, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  validates :goal_longitude, presence: true, numericality: {greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  validates :distance, presence: true, numericality: true
  validates :elevation_gain, presence: true, numericality: true
  validates :difficulty, presence: true
  validates :area, presence: true

  # ActiveStorageを使用するための記述
  has_one_attached :image

  has_many :check_points
  has_many :favorites, class_name: "RoadFavorite", dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, class_name: "RoadComment", dependent: :destroy
  has_many :waypoints

  # 閲覧数を使用するための記述
  is_impressionable

  enum difficulty: { easy: 0, normal: 1, hard: 2 }
  enum area: {
    Hokkaido: 0,
    Tohoku: 1,
    Kanto: 2,
    Chubu: 3,
    Kinki: 4,
    Chugoku: 5,
    Shikoku: 6,
    Kyusyu: 7,
  }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
