require 'rails_helper'

RSpec.describe School, type: :model do
  it 'should return the school latitude in wgs84' do
    school = create(:school)
    expect(school.wgs84_lat.to_s).to match(/\d{2}\.\d{13}/)
  end
end
