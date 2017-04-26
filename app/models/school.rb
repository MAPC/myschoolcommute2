class School < ActiveRecord::Base
  belongs_to :district
  has_many :surveys

  after_save :update_sheds, if: :geometry_changed?

  scope :with_active_surveys, -> () {
    self.joins(:surveys)
        .where('surveys.begin <= ? AND surveys.end >= ?', DateTime.now, DateTime.now)
  }

  def has_active_survey?
    surveys.where('begin <= ? AND "end" >= ?', now, now).present?
  end

  private 

    def update_sheds
      # TODO: active job or sidekick or rabbit mq
      sheds = WalkshedQuery.new(id).execute

      # adds sheds to columns
      update_columns({  shed_05: sheds[0]['_05'],
                        shed_10: sheds[0]['_10'],
                        shed_15: sheds[0]['_15'],
                        shed_20: sheds[0]['_20'] })

      # converts sheds into rings
      shed_10_ring = shed_10.difference(shed_05).to_s
      shed_15_ring = shed_15.difference(shed_10).to_s
      shed_20_ring = shed_20.difference(shed_15).to_s

      # updates with new rings
      update_columns({  shed_10: shed_10_ring,
                        shed_15: shed_15_ring,
                        shed_20: shed_20_ring  })
      
    end

    def now
      DateTime.now
    end

end

