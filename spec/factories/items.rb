FactoryBot.define do
  factory :item do
    name             {Faker::Lorem.sentence}
    details          {Faker::Lorem.sentence}
    category_id      {Faker::Number.between(from: 2, to: 11)}
    prefecture_id    {Faker::Number.between(from: 2, to: 48)}
    shipping_cost_id {Faker::Number.between(from: 2, to: 3)}
    shipping_date_id {Faker::Number.between(from: 2, to: 4)}
    status_id        {Faker::Number.between(from: 2, to: 7)}
    price            {Faker::Number.between(from: 300, to: 9999999)}

    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
