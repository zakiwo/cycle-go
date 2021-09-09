class Admin::CheckPointsController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @road = Road.find(params[:road_id])
    @check_point = CheckPoint.find(params[:id])
  end

  def update
    @check_point = CheckPoint.find(params[:id])
    if @check_point.update(check_point_params)
      flash[:notice] = "チェックポイントの更新ができました"
      redirect_to admin_road_path(@check_point.road)
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
