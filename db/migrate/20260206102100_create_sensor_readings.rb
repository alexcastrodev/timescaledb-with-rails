class CreateSensorReadings < ActiveRecord::Migration[8.1]
  def up
    # https://github.com/timescale/timescaledb-ruby
    hypertable_options = {
      time_column: 'time_at',
      chunk_time_interval: '1 day',
      compress_segmentby: 'device_id',
      compress_after: '7 days',
      compress_orderby: 'time_at DESC',
      drop_after: '90 days'
    }

    create_table :sensor_readings, id: false, hypertable: hypertable_options do |t|
      t.timestamptz :time_at, null: false
      t.text :device_id, null: false
      t.float :temperature
      t.float :humidity
      t.float :voltage
    end

    add_index :sensor_readings, :time_at, order: { time_at: :desc }
    add_index :sensor_readings, :device_id
    add_index :sensor_readings, [:device_id, :time_at], order: { time_at: :desc }
  end

  def down
    drop_table :sensor_readings
  end
end
