class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :road_favorites, dependent: :destroy
  has_many :favorite_roads, through: :road_favorites, source: :road
  has_many :road_comments, dependent: :destroy
  has_many :check_point_comments, dependent: :destroy

  def has_already_comment?(model)
    if model.class == Road
      self.road_comments.where(road_id: model.id).exists?
    elsif model.class == CheckPoint
      self.check_point_comments.where(check_point_id: model.id).exists?
    end
  end
end
