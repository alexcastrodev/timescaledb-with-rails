class EnableTimescaledb < ActiveRecord::Migration[8.1]
  def up
    execute "CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;"
  end

  def down
    execute "DROP EXTENSION IF EXISTS timescaledb CASCADE;"
  end
end
