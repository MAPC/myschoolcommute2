require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  test "walkshed generator should return truthy something for half-mile radius" do
    sheds = WalkshedQuery.new(School.last.id).execute
    assert sheds[0]['_05']
  end
end
