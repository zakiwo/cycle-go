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
  validates :area, presence: true

  # ActiveStorageを使用
  has_one_attached :image

  has_many :check_points
  has_many :favorites, class_name: "RoadFavorite", dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, class_name: "RoadComment", dependent: :destroy

  # 閲覧数
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
