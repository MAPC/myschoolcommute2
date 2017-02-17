class SurveyResponse < ActiveRecord::Base
  after_save :find_intersecting_shed, if: :geometry_changed?
  belongs_to :survey
  has_one :school, through: :survey

  def find_intersecting_shed
    update_columns(shed: IntersectionQuery.new(geometry.to_s, school).execute)
  end
end
