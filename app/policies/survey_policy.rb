class SurveyPolicy < ApplicationPolicy
  def show?
    record.end > Date.today
  end
end
