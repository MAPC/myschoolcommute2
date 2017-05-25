class Survey < ActiveRecord::Base
  has_many :survey_responses
  belongs_to :school

  validates :begin, presence: true

  scope :active, -> () {
    self.where('surveys.begin <= ? AND surveys.end >= ?', DateTime.now, DateTime.now)
  }

end
