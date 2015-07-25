FactoryGirl.define do
  rand_str = "#{Time.now.to_i}_#{rand(100)}"
  factory :note do
    user_id "111111"
    title "title#{rand_str}"
    content "content#{rand_str}"
  end
end
