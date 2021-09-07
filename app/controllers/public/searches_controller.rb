class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    if params[:category] == "road"
      @searches = Road.where(["name like? OR introduction like?", "%#{@word}%", "%#{@word}%"])
    elsif params[:category] == "area"
      @searches = Road.where(area: params[:word])
    end
  end
end
