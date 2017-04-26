require 'rails_helper'

RSpec.describe "districts/show", type: :view do
  before(:each) do
    @district = assign(:district, District.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
