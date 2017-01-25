class Household < ActiveRecord::Base
  belongs_to :survey_set
  has_many :surveys
end
