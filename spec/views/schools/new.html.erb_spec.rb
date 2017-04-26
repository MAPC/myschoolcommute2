require 'rails_helper'

RSpec.describe "schools/new", type: :view do
  before(:each) do
    assign(:school, School.new())
  end

  it "renders new school form" do
    render

    assert_select "form[action=?][method=?]", schools_path, "post" do
    end
  end
end
