require 'rails_helper'

RSpec.describe "survey_responses/new", type: :view do
  before(:each) do
    assign(:survey_response, SurveyResponse.new())
  end

  it "renders new survey_response form" do
    render

    assert_select "form[action=?][method=?]", survey_responses_path, "post" do
    end
  end
end
