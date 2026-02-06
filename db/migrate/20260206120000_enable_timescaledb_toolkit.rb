class EnableTimescaledbToolkit < ActiveRecord::Migration[8.1]
  def up
    execute "CREATE EXTENSION IF NOT EXISTS timescaledb_toolkit CASCADE;"
  end

  def down
    execute "DROP EXTENSION IF EXISTS timescaledb_toolkit;"
  end
end
