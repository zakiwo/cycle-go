require 'rails_helper'

RSpec.describe CheckPoint, type: :model do
  before do
    road = create(:road)
  end
  it "名前、説明、緯度、経度、カテゴリーがある場合、有効である" do
    check_point = create(:check_point)
    expect(check_point).to be_valid
  end

  it '名前がない場合、無効になる' do
    check_point = CheckPoint.new(
      road_id: 1,
      name: '',
      introduction: 'サイクリングロードの中程にあり、休憩できる',
      latitude: 34.8175348985952,
      longitude: 135.645234625907,
      )
      check_point.valid?
      expect(check_point.errors[:name]).to include("名前を入力してください。")
  end

  it '説明がない場合、無効になる' do
    check_point = CheckPoint.new(
      name: '関西医科大学',
      introduction: '',
      latitude: 34.8175348985952,
      longitude: 135.645234625907,
      )
      check_point.valid?
      expect(check_point.errors[:introduction]).to include("説明を入力してください。")
  end

  it '経度がない場合、無効になる' do
    check_point = CheckPoint.new(
      name: '関西医科大学',
      introduction: 'サイクリングロードの中程にあり、休憩できる',
      latitude: '',
      longitude: 135.645234625907,
      )
      check_point.valid?
      expect(check_point.errors[:latitude]).to include("地点の緯度を入力してください。")
  end

  it '緯度がない場合、無効になる' do
    check_point = CheckPoint.new(
      name: '関西医科大学',
      introduction: 'サイクリングロードの中程にあり、休憩できる',
      latitude: 34.8175348985952,
      longitude: '',
      )
      check_point.valid?
      expect(check_point.errors[:longitude]).to include("地点の経度を入力してください。")
  end

  it "カテゴリーのenumが正しく日本語化されている" do
    check_point = create(:check_point)
    expect(check_point.category_i18n).to eq '休憩できるポイント！'
  end
end