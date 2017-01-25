class SurveySet < ActiveRecord::Base
  belongs_to :school
  has_many :households
end
