class Public::RoadsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @roads = Road.all.page(params[:page]).per(3)
  end

  def show
    @road = Road.find(params[:id])
    @comment = RoadComment.new
  end

  def new
    @road = Road.new
  end

  def create
    @road = Road.new(road_params)
    @road.user_id = current_user.id
    if @road.save
      flash[:notice] = '新しいサイクリングロードの登録が完了しました'
      redirect_to road_path(@road)
    else
      render :new
    end
  end

  def edit
    @road = Road.find(params[:id])
  end

  def update
    @road = Road.find(params[:id])
    if @road.update(road_params)
      flash[:notice] = 'サイクリングロードの更新が完了しました'
      redirect_to road_path(@road)
    else
      render :edit
    end
  end

  def favorite
    @roads = current_user.favorite_roads.page(params[:page]).per(3)
  end

  private
  def road_params
    params.require(:road).permit(:name, :introduction, :start_latitude, :start_longitude, :goal_latitude, :goal_longitude, :distance, :elevation_gain, :difficulty, :is_editable, :image, :area)
  end
end
