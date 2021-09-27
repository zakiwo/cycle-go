class Public::WaypointsController < ApplicationController
  before_action :authenticate_user!

  def index
    @road = Road.find(params[:road_id])
    @waypoint = Waypoint.new
    @waypoints = @road.waypoints
  end

  def create
    @road = Road.find(params[:road_id])
    @waypoint = Waypoint.new(waypoint_params)
    @waypoint.road_id = params[:road_id]
    @waypoint.user_id = current_user.id
    #経由順番の最後を取得し、プラス1の値を付与
    if last_waypoint = @road.waypoints.order(:point_no).last
      @waypoint.point_no = last_waypoint.point_no + 1
    else
      @waypoint.point_no = 1
    end
    if @waypoint.save
      flash[:notice] = '新しい経由地点の登録が完了しました'
      redirect_to road_path(@road)
    else
      render :index
    end
  end

  def edit
    @road = Road.find(params[:road_id])
    @waypoint = Waypoint.find(params[:id])
  end

  def update
    road = Road.find(params[:road_id])
    @waypoint = Waypoint.find(params[:id])
    if @waypoint.update(waypoint_params)
      flash[:notice] = '経由地点の更新が完了しました'
      redirect_to road_path(road)
    else
      render :edit
    end
  end

  def destroy
    road = Road.find(params[:road_id])
    Waypoint.find(params[:id]).destroy
    flash[:notice] = "経由地点を削除しました"
    redirect_to road_path(road)
  end

  private

  def waypoint_params
    params.require(:waypoint).permit(
      :name,
      :latitude,
      :longitude,
      :point_no,
    )
  end
end
