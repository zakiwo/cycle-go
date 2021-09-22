class Admin::CheckPointsController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @road = Road.find(params[:road_id])
    @check_point = CheckPoint.find(params[:id])
  end

  def update
    @check_point = CheckPoint.find(params[:id])
    if @check_point.update(check_point_params)
      flash[:notice] = "チェックポイントの更新が完了しました"
      redirect_to admin_road_path(@check_point.road)
    else
      render :edit
    end
  end

  def destroy
    road = Road.find(params[:road_id])
    CheckPoint.find(params[:id]).destroy
    flash[:notice] = "チェックポイントを削除しました"
    redirect_to admin_road_path(road)
  end

  private

  def check_point_params
    params.require(:check_point).permit(
      :name,
      :introduction,
      :latitude,
      :longitude,
      :category,
      :image
    )
  end
end
