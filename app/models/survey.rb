class Survey < ActiveRecord::Base
  has_many :survey_responses
  belongs_to :school
end
