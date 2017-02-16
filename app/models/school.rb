class School < ActiveRecord::Base
  belongs_to :district
  has_many :surveys

  after_save :update_sheds

  scope :with_active_surveys, -> () {
    self.joins(:surveys)
        .where('surveys.begin < ? AND surveys.end > ?', DateTime.now, DateTime.now)
  }

  def has_active_survey?
    surveys.where('begin < ? AND end > ?', now, now).present?
  end

  private 

  def update_sheds
    # active job or sidekick or rabbit mq
    sheds = WalkshedQuery.new(id).execute
    shed_05 = sheds[0]['_05']
    shed_10 = sheds[0]['_10']
    shed_15 = sheds[0]['_15']
    shed_20 = sheds[0]['_20']
  end

  def now
    DateTime.now
  end

end

# https://mapzen.com/documentation/mobility/isochrone/api-reference/
# https://matrix.mapzen.com/isochrone?json={"locations":[{"lat":"42.118476","lon":"-70.953508"}],"costing":"pedestrian","denoise":0.3,"polygons":true,"generalize":50,"costing_options":{"pedestrian":{"use_ferry":0}},"contours":[{"time":10},{"time":20},{"time":30},{"time":40}]}
