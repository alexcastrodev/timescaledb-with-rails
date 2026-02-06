namespace :sensor_stats do
  desc "Refresh sensor_stats continuous aggregate (all historical data)"
  task refresh: :environment do
    ActiveRecord::Base.connection.execute(
      "CALL refresh_continuous_aggregate('sensor_stats', NULL, NOW())"
    )
    puts "Done. #{SensorStat.count} rows materialized."
  end
end
