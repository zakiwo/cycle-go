class Public::RoadFavoritesController < ApplicationController
  def create
    @road = Road.find(params[:road_id])
    current_user.road_favorites.create(road_id: @road.id)
  end

  def destroy
    @road = Road.find(params[:road_id])
    current_user.road_favorites.find_by(road_id: @road.id).destroy
  end
end