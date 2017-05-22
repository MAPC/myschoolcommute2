require 'rails_helper'

RSpec.describe "survey_responses/index", type: :view do
  before(:each) do
    assign(:survey_responses, [
      SurveyResponse.create!(),
      SurveyResponse.create!()
    ])
  end

  it "renders a list of survey_responses" do
    render
  end
end
