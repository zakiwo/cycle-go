require 'rails_helper'

RSpec.feature 'ログイン後の操作' do
  background do
    Road.create!(name: '淀川サイクリングロード', introduction: "淀川沿いに、大阪の中心から京都まで行くルート。", start_latitude: 34.72182943880068, start_longitude: 135.5171911744655, goal_latitude: 34.89057364482206, goal_longitude: 135.70140959744964, distance: 27, elevation_gain: 65, difficulty: "normal", is_editable: nil, area:4)
    User.create!(first_name: '太郎', last_name: '山田', nick_name: '山ちゃん', email: 'foo@example.com', password: 'taroyamada', introduction: '山田です。よろしくお願いします。' )
  end
  scenario 'ログイン画面からログインする' do
    visit new_user_session_path
    fill_in 'user_email', with: 'foo@example.com'
    fill_in 'user_password', with: 'taroyamada'
    click_on 'Log in'
    expect(page).to have_content 'ログインしました。'
  end

  scenario 'ロードの地図リンクをクリックし、ロード詳細画面に遷移する' do
  end
end