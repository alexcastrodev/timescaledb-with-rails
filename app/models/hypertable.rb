class Hypertable < ApplicationRecord
  self.abstract_class = true

  extend Timescaledb::ActsAsHypertable
end
