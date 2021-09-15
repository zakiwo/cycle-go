class Admin::RoadsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @roads = Road.all.page(params[:page]).per(10)
  end

  def show
    @road = Road.find(params[:id])
  end

  def edit
    @road = Road.find(params[:id])
  end

  def update
    @road = Road.find(params[:id])
    if @road.update(road_params)
      flash[:notice] = "サイクリングロードの更新が完了しました"
      redirect_to admin_road_path(@road)
    else
      render :edit
    end
  end

  def destroy
    Road.find(params[:id]).destroy
    flash[:notice] = "サイクリングロードを削除しました"
    redirect_to admin_roads_path
  end

  private
  def road_params
    params.require(:road).permit(:name, :introduction, :start_latitude, :start_longitude, :goal_latitude, :goal_longitude, :distance, :elevation_gain, :difficulty, :is_editable, :image, :area)
  end
end
