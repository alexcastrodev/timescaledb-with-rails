# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_02_06_120001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "timescaledb"
  enable_extension "timescaledb_toolkit"

  create_table "sensor_readings", id: false, force: :cascade do |t|
    t.text "device_id", null: false
    t.float "humidity"
    t.float "temperature"
    t.timestamptz "time_at", null: false
    t.float "voltage"
    t.index ["device_id", "time_at"], name: "index_sensor_readings_on_device_id_and_time_at", order: { time_at: :desc }
    t.index ["device_id"], name: "index_sensor_readings_on_device_id"
    t.index ["time_at"], name: "index_sensor_readings_on_time_at", order: :desc
    t.index ["time_at"], name: "sensor_readings_time_at_idx", order: :desc
  end
  create_hypertable "sensor_readings", time_column: "time_at", chunk_time_interval: "1 day", compress_segmentby: "device_id", compress_orderby: "time_at DESC", compress_after: "P7D"

  create_retention_policy "sensor_readings", drop_after: "P90D"
  create_continuous_aggregate("sensor_stats", <<-SQL, materialized_only: true, finalized: )
    SELECT time_bucket('PT15M'::interval, time_at) AS time_at,
      device_id,
      avg(temperature) AS avg_temperature,
      min(temperature) AS min_temperature,
      max(temperature) AS max_temperature,
      approx_percentile((0.50)::double precision, percentile_agg(temperature)) AS median_temperature,
      approx_percentile((0.95)::double precision, percentile_agg(temperature)) AS p95_temperature,
      approx_percentile((0.99)::double precision, percentile_agg(temperature)) AS p99_temperature,
      avg(humidity) AS avg_humidity,
      min(humidity) AS min_humidity,
      max(humidity) AS max_humidity,
      approx_percentile((0.50)::double precision, percentile_agg(humidity)) AS median_humidity,
      approx_percentile((0.95)::double precision, percentile_agg(humidity)) AS p95_humidity,
      approx_percentile((0.99)::double precision, percentile_agg(humidity)) AS p99_humidity,
      avg(voltage) AS avg_voltage,
      min(voltage) AS min_voltage,
      max(voltage) AS max_voltage,
      approx_percentile((0.50)::double precision, percentile_agg(voltage)) AS median_voltage,
      approx_percentile((0.95)::double precision, percentile_agg(voltage)) AS p95_voltage,
      approx_percentile((0.99)::double precision, percentile_agg(voltage)) AS p99_voltage,
      count(*) AS sample_count
     FROM sensor_readings
    GROUP BY (time_bucket('PT15M'::interval, time_at)), device_id
  SQL

end
