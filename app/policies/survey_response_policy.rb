class SurveyResponsePolicy < ApplicationPolicy
  def index?
    user != nil and (user.is_admin?)
  end

  def new?
    user != nil and (user.is_admin? or user.is_district?)
  end

  def create?
    survey = Survey.find(record.survey_id)
    (user != nil and (user.is_admin? or user.is_district?)) or survey.end > Date.today
  end
end