# Logical Replication on Postgres

Inspired by https://blog.raveland.org/post/postgresql_lr_en/ and [Aurora PostgreSQL Replication for Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Replication.Logical.html)

An example application is our [Virtual Knowledge Graph](https://github.com/noi-techpark/odh-vkg).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Source database configuration: Regular Setup](#source-database-configuration-regular-setup)
- [Source database configuration: AWS/RDS](#source-database-configuration-awsrds)
- [Subscriber database configuration](#subscriber-database-configuration)
  - [Unsubscribing](#unsubscribing)
- [Schema evolution](#schema-evolution)
- [Possible changes](#possible-changes)
  - [JSON level](#json-level)
    - [Key added](#key-added)
    - [Key removed](#key-removed)
  - [Column level](#column-level)
    - [Column added](#column-added)
    - [Column removed](#column-removed)
  - [Table level](#table-level)
    - [Table added](#table-added)
    - [Table removed](#table-removed)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


## Source database configuration: Regular Setup

The WAL level of the Source database needs to be set to the logical level.

First check, what the current status is:
```sql
SHOW wal_level;
```

If it is not already `logical`, and you have superuser rights, just issue the
following command:
```sql
ALTER SYSTEM SET wal_level = 'logical';
```

On the Source database, one needs to create a dedicated role for replication (here
`replication_user`), create a publication (here `my_publication`) and grant access to the
tables to the dedicated role.
```sql
CREATE ROLE replication_user WITH LOGIN PASSWORD 's3cret' REPLICATION;
CREATE PUBLICATION my_publication FOR ALL TABLES;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO replication_user;
```

## Source database configuration: AWS/RDS

The WAL level of the Source database needs to be set to the logical level.

First check, what the current status is:
```sql
SHOW wal_level;
```

If it is not already `logical`, do: Create a new "parameter group" and within
that, set the instance parameter `rds.logical_replication` to `1` and reboot
your instance.

On the Source database, one needs to create a dedicated role for replication (here
`replication_user`), create a publication (here `my_publication`) and grant access to the
tables to the dedicated role.
```sql
CREATE ROLE replication_user WITH LOGIN PASSWORD 's3cret';
GRANT rds_replication TO replication_user;
CREATE PUBLICATION my_publication FOR ALL TABLES;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO replication_user;
```

## Subscriber database configuration

If the Source database is a Docker container on the same machine, one must make
sure they are on the same Docker network than the Source database container.

Connect to the shell and open `psql`
```sh
docker exec -it my_Subscriber database_db /bin/sh
psql -U tourismuser
```

Make sure, that the Subscriber database can access the Source database via TCP.
Check firewall rules.

Let the Subscriber database subscribe to the publication:
```sql
CREATE SUBSCRIPTION my_subscription 
  CONNECTION 'host=odh-tourism-db1 dbname=tourismuser user=replication_user password=s3cret' 
  PUBLICATION my_publication
  WITH (enabled = false);
```
Note that the subscription `my_subscription` must not already exist (otherwise
give it another name). In addition, it should not be enabled when you plan to
add triggers or other mechanisms first, that will perform actions on every CRUD
operation. Start the logical replication then with 

```SQL
ALTER SUBSCRIPTION my_subscription ENABLE;
```

### Unsubscribing

Before removing the Subscriber database container, it is recommended to disable
the subscription:
```sql
ALTER SUBSCRIPTION my_subscription DISABLE;
```

## Schema evolution

This documentation provides recommendations on how to proceed when the schema of
the source changes. Based on the [pgdash.io
blog](https://pgdash.io/blog/postgres-replication-gotchas.html). For all SQL
statements that involve a change of the schema surround them with the following
snippet:

```sql
-- pause replication (destination side)
ALTER SUBSCRIPTION my_subscription DISABLE;

-- put your schema changing statements here
ALTER TABLE ....

-- resume replication
ALTER SUBSCRIPTION my_subscription ENABLE;
```

## Possible changes
### JSON level

#### Key added
A new JSON key is first safely ignored. 

#### Key removed
However, one should plan to remove soon the mapping entries using that key.
Indeed, they may break once the derived tables and triggers are regenerated, as
the corresponding column won't appear anymore.

In case of an array, the derived table for the old array is now useless. Please
write by hand a SQL script for cleaning the derived table and its trigger.

### Column level

#### Column added
Adding a column in a source table will stop the replication until the same
column is added to the corresponding replicated table.

#### Column removed
At the moment only two columns in the mirror tables are used for building
derived tables: `id` and `data`. However, removing an additional column may
break the replication.

### Table level

#### Table added
Given that the subscription has been created for all the tables, it should stop
the replication until the corresponding table is added on the slave after the
first row is inserted.

#### Table removed
It does not seems to complain.