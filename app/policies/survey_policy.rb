class SurveyPolicy < ApplicationPolicy
  def show?
    record.begin?
  end
end
