FactoryBot.define do
  factory :topic do
    title { "rspec title test2" }
    content { "MyText2" }
    association :user
    views_count { 1 }
    pinned { false }
    locked { false }
  end
end
