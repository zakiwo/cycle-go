class Public::RoadsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :sort, :sort_point]
  impressionist :actions => [:show]

  def index
    @messages = Road.all.limit(3)
    @roads = Road.all.page(params[:page]).per(3)
  end

  def show
    @messages = Road.all.limit(3)
    @road = Road.find(params[:id])
    impressionist(@road, nil, unique: [:session_hash.to_s])
    @comment = RoadComment.new
  end

  def new
    @road = Road.new
    @waypoint = Waypoint.new
  end

  def create
    @road = Road.new(road_params)
    @road.user_id = current_user.id
    @waypoint = Waypoint.new(waypoint_params[:waypoint])
    if @road.save
      flash[:notice] = '新しいサイクリングロードの登録が完了しました'
      redirect_to road_path(@road)
    else
      render :new
    end
  end

  def edit
    @road = Road.find(params[:id])
    @waypoint = Waypoint.new
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
    @messages = Road.all.limit(3)
  end

  def sort
    @messages = Road.all.limit(3)
    sort = params[:sort]
    if sort == "favorite"
      @roads = Kaminari.paginate_array(
        Road.all.sort_by { |road| road.favorites.count }.reverse
      ).page(params[:page]).per(3)
    elsif sort == "latest"
      @roads = Road.all.order(
        "created_at DESC"
      ).page(params[:page]).per(3)
    elsif sort == "views"
      @roads = Kaminari.paginate_array(
        Road.all.sort_by { |road| road.impressionist_count }.reverse
      ).page(params[:page]).per(3)
    end
    render 'index'
  end

  def sort_point
    @road = Road.find(params[:id])
    category = params[:category]
    if category == "all"
      @check_points =
        CheckPoint.where(road_id: @road.id).page(params[:page]).per(6)
    else
      @check_points =
        CheckPoint.where(
          road_id: @road.id
        ).where(
          category: category
        ).page(params[:page]).per(6)
    end
  end

  private

  def road_params
    params.require(:road).permit(
      :name,
      :introduction,
      :start_latitude,
      :start_longitude,
      :goal_latitude,
      :goal_longitude,
      :distance,
      :elevation_gain,
      :difficulty,
      :is_editable,
      :image,
      :area
    )
  end

  def waypoint_params
    params.require(:road).permit(
      waypoint[:latitude, :longitude])
  end
end
