class District < ActiveRecord::Base
  has_many :schools
  has_many :surveys, through: :schools

  scope :active, -> () {
    School.active.map(&:district)
  }
end
