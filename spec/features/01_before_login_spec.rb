require 'rails_helper'

RSpec.feature 'ログイン前の操作' do
  background do
    User.create!(first_name: '太郎', last_name: '山田', nick_name: '山ちゃん', email: 'foo@example.com', password: 'taroyamada', introduction: '山田です。よろしくお願いします。' )
    Road.create!(user_id: 1, name: '淀川サイクリングロード', introduction: "淀川沿いに、大阪の中心から京都まで行くルート。", start_latitude: 34.72182943880068, start_longitude: 135.5171911744655, goal_latitude: 34.89057364482206, goal_longitude: 135.70140959744964, distance: 27, elevation_gain: 65, difficulty: "normal", is_editable: nil, area:4)
    CheckPoint.create!(user_id: 1, road_id: 1, name: '関西医科大学', introduction: '関西医科大学の裏側', latitude: 34.81753489859529, longitude: 135.64523462590745, category: 1)
    RoadComment.create!(user_id: 1, road_id: 1, body: '大阪一のオススメ')
    visit root_path
  end

  scenario 'ロードの一覧画面が見れる' do
    expect(page).to have_link '淀川サイクリングロード'
  end

  scenario 'ロードの詳細画面が見れる' do
    click_on '淀川サイクリングロード'
    expect(current_path).to eq road_path(1)
  end

  scenario 'コメントが見れる' do
    click_on '淀川サイクリングロード'
    expect(page).to have_content '大阪一のオススメ'
  end

  scenario 'チェックポイントが見れる' do
    click_on '淀川サイクリングロード'
    click_on '関西医科大学'
    expect(page).to have_content '関西医科大学の裏側'
  end
end