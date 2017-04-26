require 'rails_helper'

RSpec.describe "schools/index", type: :view do
  before(:each) do
    assign(:schools, [
      School.create!(),
      School.create!()
    ])
  end

  it "renders a list of schools" do
    render
  end
end
