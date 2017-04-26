require 'rails_helper'

RSpec.describe "districts/index", type: :view do
  before(:each) do
    assign(:districts, [
      District.create!(),
      District.create!()
    ])
  end

  it "renders a list of districts" do
    render
  end
end
