namespace :database do
  desc "Correct id sequences"
  task correct_seq_id: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  desc "Correct distance entries"
  task correct_distances: :environment do
    corrupted = SurveyResponse.where('distance < 0')
    
    puts "Fixing #{corrupted.size} corrupted records..."

    corrupted.each do |record|
      record.calculate_distance
      record.touch(:updated_at)
    end
  end
end
