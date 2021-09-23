class Admin::RoadCommentsController < ApplicationController
  def destroy
    road = Road.find(params[:road_id])
    RoadComment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to admin_road_path(road)
  end
end
