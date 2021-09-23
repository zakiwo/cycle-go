require 'rails_helper'

RSpec.feature 'ログイン後の操作' do
  background do
    Admin.create!(
      email: 'admin@example.com',
      password: 'adminadmin'
    )
    User.create!(
      first_name: '太郎',
      last_name: '山田',
      nick_name: '山ちゃん',
      email: 'foo@example.com',
      password: 'taroyamada',
      introduction: '山田です。よろしくお願いします。'
    )
    User.create!(
      first_name: '花子',
      last_name: '山田',
      nick_name: 'ハナちゃん',
      email: 'hanako@example.com',
      password: 'hanakoyamada',
      introduction: '花子です。よろしく。'
    )
    Road.create!(
      user_id: 1,
      name: '淀川サイクリングロード',
      introduction: "淀川沿いに、大阪の中心から京都まで行くルート。",
      start_latitude: 34.72182943880068,
      start_longitude: 135.5171911744655,
      goal_latitude: 34.89057364482206,
      goal_longitude: 135.70140959744964,
      distance: 27,
      elevation_gain: 65,
      difficulty: "normal",
      is_editable: nil,
      area: 4
    )
    CheckPoint.create!(
      user_id: 1,
      road_id: 1,
      name: '関西医科大学',
      introduction: '関西医科大学の裏側',
      latitude: 34.81753489859529,
      longitude: 135.64523462590745,
      category: 1
    )

    # adminのログイン
    visit new_admin_session_path
    fill_in 'admin_email', with: 'admin@example.com'
    fill_in 'admin_password', with: 'adminadmin'
    click_on 'Log in'
  end

  scenario 'ログイン' do
    expect(page).to have_content 'ログインしました。'
  end

  scenario 'ユーザー一覧へ' do
    click_on 'USERS'
    expect(page).to have_content '山ちゃん'
  end

  scenario 'ユーザー情報を変更' do
    click_on 'USERS'
    all('tbody tr')[0].click_on '編集する'
    fill_in 'user_introduction', with: '山田だよ。よろしくね。'
    click_on '更新'
    expect(page).to have_content 'ユーザー情報を更新しました'
  end

  scenario 'ロードを編集する' do
    all('.nav-item')[2].click_on 'ROADS'
    click_on '編集する'
    fill_in 'road_name', with: '淀川サイクリングロード(右岸)'
    click_on 'ロード情報を更新'
    expect(page).to have_content 'サイクリングロードの更新が完了しました'
  end

  scenario 'ロードを削除する' do
    all('.nav-item')[2].click_on 'ROADS'
    click_on '削除する'
    expect(page).to have_content 'サイクリングロードを削除しました'
  end

  scenario 'チェックポイントを編集する' do
    all('.nav-item')[2].click_on 'ROADS'
    click_on '淀川サイクリングロード'
    click_on '編集する'
    fill_in 'check_point_name', with: '関西医科大学（裏手）'
    click_on 'チェックポイントを編集'
    expect(page).to have_content 'チェックポイントの更新が完了しました'
  end

  scenario 'チェックポイントを削除する' do
    all('.nav-item')[2].click_on 'ROADS'
    click_on '淀川サイクリングロード'
    click_on '削除する'
    expect(page).to have_content 'チェックポイントを削除しました'
  end
end
