FactoryBot.define do
  factory :user do
    email { 'example1@example.com' }
    password { 'devnull123' }
    is_admin { true }
  end
end
