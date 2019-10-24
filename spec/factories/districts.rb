FactoryBot.define do
  factory :district do
    add_attribute(:name) { 'Lexington' }
    distname { 'Lexington' }
    slug { '' }
    startgrade { '1' }
    endgrade { '12' }
    distcode4 { '' }
    distcode8 { '' }
    districtid_id { '' }
    geometry { '' }
  end
end
