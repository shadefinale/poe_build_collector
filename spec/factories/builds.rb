FactoryGirl.define do
  factory :build do
    sequence(:title) { |n|  "My awesome build #{n}" }
    sequence(:url) { |n| "awesome/build/#{n}" }
    replies 0
    sequence(:char) { |n| n % 7 + 1}
    author
    skill
  end
end
