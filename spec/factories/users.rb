FactoryBot.define do
  factory :user do
    name                  { Faker::Name.initials(number: 4) }
    first_name            { '太郎' } # 全角文字
    last_name             { '山田' } # 全角文字
    first_name_kana       { 'タロウ' } # 全角カタカナ
    last_name_kana        { 'ヤマダ' } # 全角カタカナ
    email                 { Faker::Internet.email }
    password              { 'password1' } # バリデーションを満たすパスワード
    password_confirmation { password }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
