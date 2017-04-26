require 'rails_helper'

RSpec.describe "schools/show", type: :view do
  before(:each) do
    @school = assign(:school, School.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
