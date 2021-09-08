class Public::CheckPointCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @road = Road.find(params[:road_id])
    @check_point = CheckPoint.find(params[:check_point_id])
    @comment = current_user.check_point_comments.new(check_point_comment_params)
    @comment.road_id = @road.id
    @comment.check_point_id = @check_point.id
    if @comment.save
      flash[:notice] = "コメントしました！"
      redirect_to road_check_point_path(@road, @check_point)
    else
      render 'check_points/show'
    end
  end

  def destroy
    CheckPointComment.find(params[:id]).destroy
    redirect_to road_check_point_path(params[:road_id], params[:check_point_id])
  end

  private
  def check_point_comment_params
    params.require(:check_point_comment).permit(:body)
  end
end
