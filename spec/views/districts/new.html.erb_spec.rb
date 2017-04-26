require 'rails_helper'

RSpec.describe "districts/new", type: :view do
  before(:each) do
    assign(:district, District.new())
  end

  it "renders new district form" do
    render

    assert_select "form[action=?][method=?]", districts_path, "post" do
    end
  end
end
