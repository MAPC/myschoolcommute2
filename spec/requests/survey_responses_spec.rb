require 'rails_helper'

RSpec.describe "SurveyResponses", type: :request do
  describe "GET /survey_responses" do
    it "works! (now write some real specs)" do
      get survey_responses_path
      expect(response).to have_http_status(200)
    end
  end
end
