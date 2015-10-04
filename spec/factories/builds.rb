FactoryGirl.define do
  factory :build do
    sequence(:title) { |n|  "My awesome build #{n}" }
    sequence(:url) { |n| "awesome/build/#{n}" }
    replies 0
    posted_date Time.now
    sequence(:char) { |n| (n % 7) }
    author
    skill
  end
end
