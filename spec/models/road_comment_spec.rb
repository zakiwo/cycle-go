require 'rails_helper'

RSpec.describe RoadComment, type: :model do
  before do
    road = create(:road)
    user = create(:user)
  end
  it "コメントができる" do
    comment = RoadComment.new(
      user_id: 1,
      road_id: 1,
      body: "ここはよく来てます"
      )
      expect(comment).to be_valid
  end

  it "コメントが空の場合、無効である" do
    comment = RoadComment.new(
      user_id: 1,
      road_id: 1,
      body: ""
      )
    comment.valid?
    expect(comment.errors[:body]).to include("コメントを入力してください。")
  end
end