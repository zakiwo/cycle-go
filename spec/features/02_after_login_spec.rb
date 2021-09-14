require 'rails_helper'

RSpec.feature 'ログイン後の操作' do
  background do
    User.create!(first_name: '太郎', last_name: '山田', nick_name: '山ちゃん', email: 'foo@example.com', password: 'taroyamada', introduction: '山田です。よろしくお願いします。' )
    Road.create!(user_id: 1, name: '淀川サイクリングロード', introduction: "淀川沿いに、大阪の中心から京都まで行くルート。", start_latitude: 34.72182943880068, start_longitude: 135.5171911744655, goal_latitude: 34.89057364482206, goal_longitude: 135.70140959744964, distance: 27, elevation_gain: 65, difficulty: "normal", is_editable: nil, area:4)
    CheckPoint.create!(user_id: 1, road_id: 1, name: '関西医科大学', introduction: '関西医科大学の裏側', latitude: 34.81753489859529, longitude: 135.64523462590745, category: 1)
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
    click_on '淀川サイクリングロード'
    click_on '編集する'
    fill_in 'road_name', with: '淀川サイクリングロード(右岸)'
    click_on 'ロード情報を更新'
    expect(page).to have_content 'サイクリングロードの更新が完了しました'
  end

  scenario '新しいサイクリングロードを登録する' do
    click_on '新規ロード作成'
    fill_in 'road_name',  with: '六甲山登頂（逆瀬川ルート)'
    fill_in 'road_introduction', with: ' "阪急逆瀬川から六甲山を登り、山頂を目指すルート'
    select '近畿', from: 'road_area'
    fill_in 'road_start_latitude', with: 34.797288879018076
    fill_in 'road_start_longitude', with: 135.35079515833087
    fill_in 'road_goal_latitude', with: 34.778193136820114
    fill_in 'road_goal_longitude', with: 135.26563684988827
    fill_in 'road_distance', with: 856
    fill_in 'road_elevation_gain', with: 11
    choose 'road_difficulty_hard'
    click_on '新しいロードを登録'
    expect(page).to have_content '新しいサイクリングロードの登録が完了しました'
    expect(page).to have_content '六甲山登頂（逆瀬川ルート)'
  end

  #js = trueにすると、下記エラー
  # Failure/Error: visit new_user_session_path
  # Selenium::WebDriver::Error::WebDriverError:
  # Could not find Firefox binary (os=linux). Make sure Firefox is installed or set the path manually with Selenium::WebDriver::Firefox::Binary.path=

  xscenario 'ロードにコメントする', js: true do
    click_on '淀川サイクリングロード'
    fill_in 'road_comment_body', with: 'ロードコメントテスト'
    click_on 'コメントする'
    expect(page).to have_content 'ロードコメントテスト'
  end

  xscenario 'ロードにいいねする' do
  end

  xscenario 'ワード検索する', js: true do
    # fill_in(:word, with: "淀川" + "\n")
    fill_in 'word', with: '淀川'
    find('#word').native.send_key(:Enter)
    expect(page).to have_content 'Search results'
  end

  scenario 'エリア検索する' do
    click_on '近畿'
    expect(page).to have_content 'Search results'
  end

  scenario 'チェックポイントの詳細に遷移する' do
    click_on '淀川サイクリングロード'
    click_on '関西医科大学'
    expect(current_path).to eq road_check_point_path(1,1)
  end

  scenario 'チェックポイントを編集する' do
    click_on '淀川サイクリングロード'
    click_on '関西医科大学'
    click_on '編集する'
    fill_in 'check_point_name', with: '関西医科大学(裏側)'
    click_on 'チェックポイントを編集'
    expect(page).to have_content 'チェックポイントを更新しました'
  end

  #JSコメント
  xscenario 'チェックポイントにコメントする', js: true do
    click_on '淀川サイクリングロード'
    click_on '関西医科大学'
    fill_in 'check_point_comment_body', with: 'チェックポイントコメントテスト'
    click_on 'コメントする'
    expect(page).to have_content 'チェックポイントコメントテスト'
  end

  scenario 'ログアウトする' do
    click_on 'LOGOUT'
    expect(page).to have_content 'ログアウトしました'
  end

  scenario '新規ユーザー登録する' do
    click_on 'LOGOUT'
    click_on 'SIGN UP'
    fill_in 'user_first_name', with: '花子'
    fill_in 'user_last_name', with: '山田'
    fill_in 'user_nick_name', with: 'ハナちゃん'
    fill_in 'user_introduction', with: 'ハナちゃんです。よろしく。'
    fill_in 'user_email', with: 'hana@example.com'
    fill_in 'user_password', with: 'hanayamada'
    fill_in 'user_password_confirmation', with: 'hanayamada'
    click_on '新規登録'
    expect(page).to have_content 'アカウント登録が完了しました。'
  end

  scenario 'ユーザー情報を編集する' do
    click_on 'MyPage'
    click_on '編集する'
    fill_in 'user_introduction', with: '山田です！よろしこ！'
    click_on '更新する'
    expect(page).to have_content '会員情報を更新しました'
  end

  scenario '退会する' do
    click_on 'MyPage'
    click_on '編集する'
    click_on '退会する'
    click_on '退会する'
    expect(page).to have_content '退会処理が完了しました。またのご利用お待ちしています。'
  end
end