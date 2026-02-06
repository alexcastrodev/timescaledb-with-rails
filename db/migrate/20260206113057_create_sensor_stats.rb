class CreateSensorStats < ActiveRecord::Migration[8.1]
  def up
    query = SensorReading.select(
        "time_bucket('15 minutes', time_at) AS time_at",
        :device_id,
        "avg(temperature) AS avg_temperature",
        "min(temperature) AS min_temperature",
        "max(temperature) AS max_temperature",
        "avg(humidity) AS avg_humidity",
        "min(humidity) AS min_humidity",
        "max(humidity) AS max_humidity",
        "avg(voltage) AS avg_voltage",
        "min(voltage) AS min_voltage",
        "max(voltage) AS max_voltage",
        "count(*) AS sample_count"
      ).group("time_bucket('15 minutes', time_at), device_id").to_sql
    
    
    create_continuous_aggregate(:sensor_stats, query)
  end

  def down
    drop_continuous_aggregate(:sensor_stats)
  end
end
