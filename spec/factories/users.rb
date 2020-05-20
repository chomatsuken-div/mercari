FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(8)
    nickname {Faker::Name.last_name}
    last_name {Faker::Name.last_name}
    first_name {Faker::Name.last_name}
    last_name_kana {Faker::Name.last_name}
    first_name_kana {Faker::Name.last_name}
    birthday {"2012-01-21"}
    phone_number {"09012341234"}
    email {Faker::Internet.free_email}
    password {password}
    password_confirmation {password}
  end
end

