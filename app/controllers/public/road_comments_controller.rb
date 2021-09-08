class Public::RoadCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @road = Road.find(params[:road_id])
    @comment = current_user.road_comments.new(road_comment_params)
    @comment.road_id = @road.id
    if @comment.save
      flash[:notice] = "コメントしました！"
      redirect_to road_path(@road)
    else
      render 'roads/show'
    end
  end

  def destroy
    RoadComment.find(params[:id]).destroy
    redirect_to road_path(params[:road_id])
  end

  private
  def road_comment_params
    params.require(:road_comment).permit(:body)
  end
end
