FactoryBot.define do
  factory :road do
    name {'淀川サイクリングロード'}
    introduction {'淀川沿いに、大阪の中心から京都まで行くルート。大阪のサイクリングロードといったらやっぱりここ。'}
    area {4}
    start_latitude {34.7214201402841}
    start_longitude {135.517055563219}
    goal_latitude {34.8907532063983}
    goal_longitude {135.701363532241}
    distance {27.8}
    elevation_gain {65}
    difficulty {1}
  end
end