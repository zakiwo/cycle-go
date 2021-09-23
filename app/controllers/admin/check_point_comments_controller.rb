class Admin::CheckPointCommentsController < ApplicationController
  def destroy
    road = Road.find(params[:road_id])
    CheckPointComment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to admin_road_path(road)
  end
end
