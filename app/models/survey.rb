class Survey < ActiveRecord::Base
  has_many :survey_responses
  belongs_to :school

  validates :begin, presence: true

  scope :active, -> () {
    self.where('surveys.begin <= ? AND surveys.end >= ?', DateTime.now, DateTime.now)
  }

  alias_attribute :survey_start, :begin
  alias_attribute :survey_end, :end

  def status
    if try(:survey_start) and try(:survey_end) 
      now = Time.now

      if now >= survey_end 
        'Finished'
      elsif now <= survey_start
        'Scheduled'
      elsif now >= survey_start and now <= survey_end 
        'In Progress'
      else
        'Unknown'
      end
    else
      'Missing Beginning and End dates' 
    end 
  end
end
