class CheckPoint < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :category, presence: true

  belongs_to :road
  has_many :comments, class_name: "CheckPointComment", dependent: :destroy

  enum category: { cautionary: 0, scenic: 1, restful: 2}

  #ActiveStorageを使用
  has_one_attached :image
end
