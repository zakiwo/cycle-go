require 'rails_helper'

RSpec.describe RoadFavorite, type: :model do
  before do
    create(:road)
    create(:user)
  end

  it "いいねができる" do
    favorite = RoadFavorite.new(
      user_id: 1,
      road_id: 1,
    )
    expect(favorite).to be_valid
  end
end
