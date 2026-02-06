# Run test env

docker compose run --rm --service-ports console-test bash

# Run development

docker compose run --rm --service-ports console-dev bash

# Database

![db](.github/snapshot.png)


# TimescaleDB

The TimescaleDB HA Docker image offers the most complete TimescaleDB experience. It uses Ubuntu, includes TimescaleDB Toolkit, and support for PostGIS and Patroni.

https://www.tigerdata.com/docs/self-hosted/latest/install/installation-docker


Why not use timescale/timescaledb:2.24.0-pg18 instead timescale/timescaledb-ha:pg18?

Because does not have the toolkit:

```
Caused by:
ActiveRecord::StatementInvalid: PG::FeatureNotSupported: ERROR:  extension "timescaledb_toolkit" is not available (ActiveRecord::StatementInvalid)
HINT:  The extension must first be installed on the system where PostgreSQL is running.
```