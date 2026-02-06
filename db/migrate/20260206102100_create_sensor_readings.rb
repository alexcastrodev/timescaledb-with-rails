class CreateSensorReadings < ActiveRecord::Migration[8.1]
  def change
    create_table :sensor_readings, 
                 id: false, 
                 hypertable: { 
                   time_column: 'time',
                   compress_segmentby: 'device_id',
                   compress_after: '7 days',
                   drop_after: '90 days'
                 } do |t|
      t.timestamptz :time, null: false
      t.text :device_id, null: false
      t.float :temperature
      t.float :humidity
      t.float :voltage
    end

    add_index :sensor_readings, :time, order: { time: :desc }
    add_index :sensor_readings, :device_id
    add_index :sensor_readings, [:device_id, :time], order: { time: :desc }
  end
end
