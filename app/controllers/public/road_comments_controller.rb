class Public::RoadCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @road = Road.find(params[:road_id])
    @comment = current_user.road_comments.new(road_comment_params)
    @comment.road_id = @road.id
    @comment.save
  end

  def destroy
    @road = Road.find(params[:road_id])
    @comment = RoadComment.new
    RoadComment.find(params[:id]).destroy
  end

  private
  def road_comment_params
    params.require(:road_comment).permit(:body)
  end
end
