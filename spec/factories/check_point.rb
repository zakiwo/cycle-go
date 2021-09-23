FactoryBot.define do
  factory :check_point do
    road_id { 1 }
    name { '関西医科大学' }
    introduction { 'サイクリングロードの中程にあり、休憩できる' }
    latitude { 34.81753489859529 }
    longitude { 135.64523462590745 }
    category { 2 }
  end
end
