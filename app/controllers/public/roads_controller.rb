class Public::RoadsController < ApplicationController
  def index
    @roads = Road.all
  end

  def show
    @road = Road.find(params[:id])
  end

  def new
    @road = Road.new
  end

  def create
    @road = Road.new(road_params)
    if @road.save
      flash[:notice] = '新しいサイクリングロードの登録が完了しました'
      redirect_to road_path(@road)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def road_params
    params.require(:road).permit(:name, :introduction, :start_latitude, :start_longitude, :goal_latitude, :goal_longitude, :distance, :elevation_gain, :difficulty, :is_editable )
  end
end
