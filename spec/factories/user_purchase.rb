FactoryBot.define do
  factory :user_purchase do
    token               { 'tok_b4ec3c72eafab5e330e5d14c25fd' }
    postal_code         { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id       { Faker::Number.between(from: 2, to: 48) }
    city                { Gimei.city.kanji }
    house_number        { Gimei.town.kanji }
    building            { Gimei.town.kanji }
    phone_number        { Faker::Number.leading_zero_number(digits: 10)}
  end
end
