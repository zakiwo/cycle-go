FactoryBot.define do
  factory :user do
    first_name{'太郎'}
    last_name {'山田'}
    nick_name {'山ちゃん'}
    email {'foo@example.com'}
    password {'taroyamada'}
    introduction {'山田です。よろしくお願いします。'}
  end
end