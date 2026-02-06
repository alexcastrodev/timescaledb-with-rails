class SensorReading < ApplicationRecord
  self.primary_key = :time

  validates :time, presence: true
  validates :device_id, presence: true
end
