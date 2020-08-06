class SurveyResponsePolicy < ApplicationPolicy
  def new?
    puts 'Accessing new policy'
    user != nil and (user.is_admin? or user.is_district?)
  end
end