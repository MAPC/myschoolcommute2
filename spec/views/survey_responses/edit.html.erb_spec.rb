require 'rails_helper'

RSpec.describe "survey_responses/edit", type: :view do
  before(:each) do
    @survey_response = assign(:survey_response, SurveyResponse.create!())
  end

  it "renders the edit survey_response form" do
    render

    assert_select "form[action=?][method=?]", survey_response_path(@survey_response), "post" do
    end
  end
end
