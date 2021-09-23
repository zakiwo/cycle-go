require 'rails_helper'

RSpec.describe User, type: :model do
  it "姓、名、自己紹介、メール、パスワードがある場合、有効である" do
    user = User.new(
      first_name: '太郎',
      last_name: '山田',
      nick_name: '山ちゃん',
      email: 'foo@example.com',
      password: 'taroyamada',
      introduction: '山田です。よろしくお願いします。'
    )
    expect(user).to be_valid
  end

  it "姓がない場合、無効である" do
    user = User.new(
      first_name: '太郎',
      last_name: '',
      nick_name: '山ちゃん',
      email: 'foo@example.com',
      password: 'taroyamada',
      introduction: '山田です。よろしくお願いします。'
    )
    user.valid?
    expect(user.errors[:last_name]).to include("姓を入力してください。")
  end

  it "名がない場合、無効である" do
    user = User.new(
      first_name: '',
      last_name: '山田',
      nick_name: '山ちゃん',
      email: 'foo@example.com',
      password: 'taroyamada',
      introduction: '山田です。よろしくお願いします。'
    )
    user.valid?
    expect(user.errors[:first_name]).to include("名を入力してください。")
  end

  it "ニックネームがない場合、無効である" do
    user = User.new(
      first_name: '太郎',
      last_name: '山田',
      nick_name: '',
      email: 'foo@example.com',
      password: 'taroyamada',
      introduction: '山田です。よろしくお願いします。'
    )
    user.valid?
    expect(user.errors[:nick_name]).to include("ニックネームを入力してください。")
  end

  it "自己紹介がなくても、有効である" do
    user = User.new(
      first_name: '太郎',
      last_name: '山田',
      nick_name: '山ちゃん',
      email: 'foo@example.com',
      password: 'taroyamada',
      introduction: ''
    )
    expect(user).to be_valid
  end

  it "メールアドレスがない場合、無効である" do
    user = User.new(
      first_name: '太郎',
      last_name: '山田',
      nick_name: '山ちゃん',
      email: '',
      password: 'taroyamada',
      introduction: '山田です。よろしくお願いします。'
    )
    user.valid?
    expect(user.errors[:email]).to include("メールアドレスを入力してください。")
  end

  it "パスワードがない場合、無効である" do
    user = User.new(
      first_name: '太郎',
      last_name: '山田',
      nick_name: '山ちゃん',
      email: 'foo@example.com',
      password: '',
      introduction: '山田です。よろしくお願いします。'
    )
    user.valid?
    expect(user.errors[:password]).to include("パスワードを入力してください。")
  end

  it "同じメールアドレスを使用すると、無効である" do
    User.create(
      first_name: '太郎',
      last_name: '山田',
      nick_name: '山ちゃん',
      email: 'foo@example.com',
      password: 'taroyamada',
      introduction: '山田です。よろしくお願いします。'
    )
    user2 = User.new(
      first_name: '花子',
      last_name: '山田',
      nick_name: '花ちゃん',
      email: 'foo@example.com',
      password: 'hanayamada',
      introduction: '山田です。よろしくお願いします。'
    )
    user2.valid?
    expect(user2.errors[:email]).to include("メールアドレスがすでに使用されています。")
  end
end
