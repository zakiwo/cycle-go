class Public::SearchesController < ApplicationController
  def search
    @messages = Road.all.limit(3)
    @word = params[:word]
    if params[:category] == "road"
      @searches = Road.where(
        ["name like? OR introduction like?", "%#{@word}%", "%#{@word}%"]
      ).page(params[:page]).per(3)
    elsif params[:category] == "area"
      @searches = Road.where(
        area: params[:word]
      ).page(params[:page]).per(3)
    end
  end

  def incremental_search
    @word = params[:word]
    @messages = Road.where(["name like? OR introduction like?", "%#{@word}%", "%#{@word}%"])
    respond_to do |format| # リクエスト形式によって処理を切り分ける
      format.html { redirect_to :root } # html形式の場合
      format.json { render json: @messages } # json形式の場合
      p @messages
    end
  end
end
