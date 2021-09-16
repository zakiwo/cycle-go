require 'rails_helper'

RSpec.describe Road, type: :model do
  it "名前、説明、開始緯度、エリア、開始経度、終了緯度、終了経度、総距離、獲得標高、難易度がある場合、有効である" do
    road = create(:road)
    expect(road).to be_valid
  end

  it "名前がない場合、無効である" do
    road = Road.new(
      name: '',
      introduction: '淀川沿いに、大阪の中心から京都まで行くルート。大阪のサイクリングロードといったらやっぱりここ。',
      area: 4,
      start_latitude: 34.7214201402841,
      start_longitude: 135.517055563219,
      goal_latitude: 34.8907532063983,
      goal_longitude: 135.701363532241,
      distance: 27.8,
      elevation_gain: 65,
      difficulty: 1
      )
      road.valid?
      expect(road.errors[:name]).to include("名前を入力してください。")
  end

  it "説明がない場合、無効である" do
    road = Road.new(
      name: '淀川サイクリングロード',
      introduction: '',
      area: 4,
      start_latitude: 34.7214201402841,
      start_longitude: 135.517055563219,
      goal_latitude: 34.8907532063983,
      goal_longitude: 135.701363532241,
      distance: 27.8,
      elevation_gain: 65,
      difficulty: 1
      )
      road.valid?
      expect(road.errors[:introduction]).to include("説明を入力してください。")
  end

  it "エリアがない場合、無効である" do
    road = Road.new(
      name: '淀川サイクリングロード',
      introduction: '淀川沿いに、大阪の中心から京都まで行くルート。大阪のサイクリングロードといったらやっぱりここ。',
      area: '',
      start_latitude: 34.7214201402841,
      start_longitude: 135.517055563219,
      goal_latitude: 34.8907532063983,
      goal_longitude: 135.701363532241,
      distance: 27.8,
      elevation_gain: 65,
      difficulty: 1
      )
      road.valid?
      expect(road.errors[:area]).to include("エリアを入力してください。")
  end

  it "開始緯度がない場合、無効である" do
    road = Road.new(
      name: '淀川サイクリングロード',
      introduction: '淀川沿いに、大阪の中心から京都まで行くルート。大阪のサイクリングロードといったらやっぱりここ。',
      area: 4,
      start_latitude: '',
      start_longitude: 135.517055563219,
      goal_latitude: 34.8907532063983,
      goal_longitude: 135.701363532241,
      distance: 27.8,
      elevation_gain: 65,
      difficulty: 1
      )
      road.valid?
      expect(road.errors[:start_latitude]).to include("開始地点の緯度を入力してください。")
  end

  it "開始経度がない場合、無効である" do
    road = Road.new(
      name: '淀川サイクリングロード',
      introduction: '淀川沿いに、大阪の中心から京都まで行くルート。大阪のサイクリングロードといったらやっぱりここ。',
      area: 4,
      start_latitude: 34.7214201402841,
      start_longitude: '',
      goal_latitude: 34.8907532063983,
      goal_longitude: 135.701363532241,
      distance: 27.8,
      elevation_gain: 65,
      difficulty: 1
      )
      road.valid?
      expect(road.errors[:start_longitude]).to include("開始地点の経度を入力してください。")
  end

  it "終了緯度がない場合、無効である" do
    road = Road.new(
      name: '淀川サイクリングロード',
      introduction: '淀川沿いに、大阪の中心から京都まで行くルート。大阪のサイクリングロードといったらやっぱりここ。',
      area: 4,
      start_latitude: 34.7214201402841,
      start_longitude:135.517055563219,
      goal_latitude: '',
      goal_longitude: 135.701363532241,
      distance: 27.8,
      elevation_gain: 65,
      difficulty: 1
      )
      road.valid?
      expect(road.errors[:goal_latitude]).to include("終了地点の緯度を入力してください。")
  end

  it "終了経度がない場合、無効である" do
    road = Road.new(
      name: '淀川サイクリングロード',
      introduction: '淀川沿いに、大阪の中心から京都まで行くルート。大阪のサイクリングロードといったらやっぱりここ。',
      area: 4,
      start_latitude: 34.7214201402841,
      start_longitude:135.517055563219,
      goal_latitude: 34.8907532063983,
      goal_longitude: '',
      distance: 27.8,
      elevation_gain: 65,
      difficulty: 1
      )
      road.valid?
      expect(road.errors[:goal_longitude]).to include("終了地点の経度を入力してください。")
  end

  it "総距離がない場合、無効である" do
    road = Road.new(
      name: '淀川サイクリングロード',
      introduction: '淀川沿いに、大阪の中心から京都まで行くルート。大阪のサイクリングロードといったらやっぱりここ。',
      area: 4,
      start_latitude: 34.7214201402841,
      start_longitude: 135.517055563219,
      goal_latitude: 34.8907532063983,
      goal_longitude: 135.701363532241,
      distance: '',
      elevation_gain: 65,
      difficulty: 1
      )
      road.valid?
      expect(road.errors[:distance]).to include("総距離を入力してください。")
  end

  it "獲得標高がない場合、無効である" do
    road = Road.new(
      name: '淀川サイクリングロード',
      introduction: '淀川沿いに、大阪の中心から京都まで行くルート。大阪のサイクリングロードといったらやっぱりここ。',
      area: 4,
      start_latitude: 34.7214201402841,
      start_longitude: 135.517055563219,
      goal_latitude: 34.8907532063983,
      goal_longitude: 135.701363532241,
      distance: 28,
      elevation_gain: '',
      difficulty: 1
      )
      road.valid?
      expect(road.errors[:elevation_gain]).to include("獲得標高を入力してください。")
  end

  it "難易度がない場合、無効である" do
    road = Road.new(
      name: '淀川サイクリングロード',
      introduction: '淀川沿いに、大阪の中心から京都まで行くルート。大阪のサイクリングロードといったらやっぱりここ。',
      area: 4,
      start_latitude: 34.7214201402841,
      start_longitude: 135.517055563219,
      goal_latitude: 34.8907532063983,
      goal_longitude: 135.701363532241,
      distance: 28,
      elevation_gain: 65,
      difficulty: ''
      )
      road.valid?
      expect(road.errors[:difficulty]).to include("難易度を入力してください。")
  end

  it "エリアのenumが正しく日本語化されている" do
    road = create(:road)
    expect(road.area_i18n).to eq '近畿'
  end

  it "難易度のenumが正しく日本語化されている" do
    road = create(:road)
    expect(road.difficulty_i18n).to eq '中級'
  end

end