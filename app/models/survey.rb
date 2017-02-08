class Survey < ActiveRecord::Base
  belongs_to :household
  has_many :survey_responses
end
