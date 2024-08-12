FactoryBot.define do
  factory :item do
    product_name { Faker::Lorem.characters(number: 40) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    product_description { Faker::Lorem.sentence }
    product_condition_id { 2 }
    category_id { 2 }
    shipping_cost_id { 2 }
    shipping_day_id { 2 }
    prefecture_id { 2 }
    association :user
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png'), 'image/png') }
  end
end
