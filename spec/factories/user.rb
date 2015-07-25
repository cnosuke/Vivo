FactoryGirl.define do
  rand_str = "#{Time.now.to_i}_#{rand(100)}"
  factory :user do
    name "name#{rand_str}"
    nickname "nickname#{rand_str}"
    email "email#{rand_str}@example.com"
    avatar_url 'https://avatars.githubusercontent.com/u/1452950?v=3'
    provider 'github'
    uid '1452950' #cnosuke
  end
end
