class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    if params[:category] == "road"
      @searches = Road.where(["name like? OR introduction like?", "%#{@word}%", "%#{@word}%"]).page(params[:page]).per(3)
    elsif params[:category] == "area"
      @searches = Road.where(area: params[:word]).page(params[:page]).per(3)
    end
  end
end
