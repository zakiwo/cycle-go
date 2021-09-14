require 'rails_helper'

RSpec.feature 'ログイン後の操作' do
  background do
    User.create!(first_name: '太郎', last_name: '山田', nick_name: '山ちゃん', email: 'foo@example.com', password: 'taroyamada', introduction: '山田です。よろしくお願いします。' )
    Road.create!(user_id: 1, name: '淀川サイクリングロード', introduction: "淀川沿いに、大阪の中心から京都まで行くルート。", start_latitude: 34.72182943880068, start_longitude: 135.5171911744655, goal_latitude: 34.89057364482206, goal_longitude: 135.70140959744964, distance: 27, elevation_gain: 65, difficulty: "normal", is_editable: nil, area:4)

    #ログイン操作
    visit new_user_session_path
    fill_in 'user_email', with: 'foo@example.com'
    fill_in 'user_password', with: 'taroyamada'
    click_on 'Log in'
    #ロード一覧画面にいる
  end
  scenario 'ログインする' do
    expect(page).to have_content 'ログインしました。'
  end

  scenario 'ロードのリンクをクリックし、ロード詳細画面に遷移する' do
    click_on '淀川サイクリングロード'
    expect(current_path).to eq road_path(1)
  end

  scenario 'ロードの編集画面に遷移する' do
    click_on '淀川サイクリングロード'
    click_on '編集する'
    expect(current_path).to eq edit_road_path(1)
  end

  scenario 'ロードを編集する' do
    fill_in 'road_name', with: '淀川サイクリングロード(右岸)'
    click_on 'ロード情報を更新'
    expect(page).to have_content 'サイクリングロードの更新が完了しました'
  end

  scenario '新しいサイクリングロードを登録する' do
    click_on '新規ロード作成'
    fill_in 'road_name',  with: '六甲山登頂（逆瀬川ルート)'
    fill_in 'road_introduction', with: ' "阪急逆瀬川から六甲山を登り、山頂を目指すルート'
    select '近畿', from: 'road_area'
    fill_in 'road_start_latitude', with: ''
    fill_in 'road_start_longitude', with: ''
    fill_in 'road_goal_latitude', with: ''
    fill_in 'road_goal_longitude', with: ''
    fill_in 'distance', with: ''
    fill_in 'elevation_gain', with: ''
    choose '上級'
    click_on '新しいロードを登録'
    expect(page).to have_content '新しいサイクリングロードの登録が完了しました'
    expect(page).to have_link '六甲山登頂（逆瀬川ルート)'
  end

  scenario 'ロードにコメントする' do
    click_on '淀川サイクリングロード'
    fill_in 'road_comment_body', with: 'ロードコメントテスト'
    click_on 'コメントする'
  end

  scenario 'ロードにいいねする' do

  end

  scenario 'ワード検索する' do
  end

  scenario 'エリア検索する' do
  end

  scenario 'チェックポイントの詳細に遷移する' do
  end

  scenario 'チェックポイントを編集する' do
  end

  scenario 'チェックポイントにコメントする' do
  end

  scenario 'ログアウトする' do
  end

  scenario '新規ユーザー登録する' do
  end

end