FactoryBot.define do
  factory :survey do
    add_attribute(:begin) { Date.yesterday }
    add_attribute(:end) { Date.tomorrow }
    add_attribute(:school_id) { 1 }
  end
end
