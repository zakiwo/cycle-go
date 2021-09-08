class Public::CheckPointsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @road = Road.find(params[:road_id])
    @check_point = CheckPoint.find(params[:id])
    @comment = CheckPointComment.new
  end

  def new
    @road = Road.find(params[:road_id])
    @check_point = CheckPoint.new
  end

  def create
    @road = Road.find(params[:road_id])
    @check_point = CheckPoint.new(check_point_params)
    @check_point.user_id = current_user.id
    @check_point.road_id = @road.id
    if @check_point.save
      flash[:notice] = "チェックポイントが登録されました"
      redirect_to road_check_point_path(@road, @check_point)
    else
      render :new
    end
  end

  def edit
    @check_point = CheckPoint.find(params[:id])
  end

  def update
    @check_point = CheckPoint.find(params[:id])
    if @check_point.update(check_point_params)
      flash[:notice] = "チェックポイントの更新ができました"
      redirect_to road_check_point_path(@check_point.road, @check_point)
    else
      render :edit
    end
  end

  def destroy
    CheckPoint.find(params[:id]).destroy
  end

  private
  def check_point_params
    params.require(:check_point).permit(:name, :introduction, :latitude, :longitude, :category, :image)
  end
end
