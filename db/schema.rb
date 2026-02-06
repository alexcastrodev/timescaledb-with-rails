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

ActiveRecord::Schema[8.1].define(version: 2026_02_06_102100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "timescaledb"

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
end
