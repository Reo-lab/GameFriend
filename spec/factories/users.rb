FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "testuser@example.com" }
    gender {"male"}
    password { "password" }
    password_confirmation { "password" }
    # その他、Userモデルに必要な属性を追加してください
  end
end