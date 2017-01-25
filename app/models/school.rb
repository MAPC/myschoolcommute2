class School < ActiveRecord::Base
  belongs_to :district
  has_many :survey_sets

  scope :with_active_surveys, -> () {
    self.joins(:survey_sets)
        .where('survey_sets.start < ? AND survey_sets.end > ?', DateTime.now, DateTime.now)
  }

  def has_active_survey?
    survey_sets.where('start < ? AND end > ?', now, now).present?
  end

  private 

  def walkshed_generator
  end

  def now
    DateTime.now
  end

end

# https://mapzen.com/documentation/mobility/isochrone/api-reference/