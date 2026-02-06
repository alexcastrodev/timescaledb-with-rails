class SensorReading < Hypertable
  acts_as_hypertable time_column: "time_at", segment_by: "device_id"

  validates :time_at, presence: true
  validates :device_id, presence: true
end
