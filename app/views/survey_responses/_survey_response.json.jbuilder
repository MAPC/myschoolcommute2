json.extract! survey_response, :id, :created_at, :updated_at
json.url survey_response_url(survey_response, format: :json)