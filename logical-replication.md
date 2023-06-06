<!--
SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Logical Replication on Postgres

Inspired by a [Raveland Blog Post](https://blog.raveland.org/post/postgresql_lr_en) and [Aurora PostgreSQL Replication for Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Replication.Logical.html).
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
COMMENT ON ROLE replication_user IS 'Role with the privileges to replicate data for the ABC project';
CREATE PUBLICATION my_publication FOR ALL TABLES;
ALTER PUBLICATION my_publication SET (publish = ''); -- Make it a read-only publication by default
GRANT USAGE ON SCHEMA public to replication_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO replication_user;
```

## Source database configuration: AWS/RDS

The WAL level of the Source database needs to be set to the logical level.

First check, what the current status is:
```sql
SHOW wal_level;
```

If it is not already `logical`, do: Create a new "parameter group" and within
that, set the instance parameter `rds.logical_replication` to `1` and
`max_wal_senders` to `15`, then reboot your instance.

On the Source database, one needs to create a dedicated role for replication (here
`replication_user`), create a publication (here `my_publication`) and grant access to the
tables to the dedicated role.
```sql
CREATE ROLE replication_user WITH LOGIN PASSWORD 's3cret';
COMMENT ON ROLE replication_user IS 'Role with the privileges to replicate data for the ABC project';
GRANT rds_replication TO replication_user;
CREATE PUBLICATION my_publication FOR ALL TABLES;
ALTER PUBLICATION my_publication SET (publish = ''); -- Make it a read-only publication by default
GRANT USAGE ON SCHEMA public to replication_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO replication_user;
```

## Subscriber database configuration

Make sure, that the subscriber database `replica_db` can access the Source
database via TCP. Check firewall rules.

We need a superuser `vkguser`, that will run all creation scripts (for instance
with Flyway), and a read-only user `vkguser_readonly` that will access the data
with less privileges for security.

```sql
CREATE ROLE vkguser WITH LOGIN PASSWORD 's3cret';
COMMENT ON ROLE vkguser IS 'Admin account to access the virtual knowledge graph';
GRANT CONNECT ON DATABASE replica_db TO vkguser;
GRANT CREATE ON SCHEMA public TO vkguser;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO vkguser;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO vkguser;
ALTER ROLE vkguser SET statement_timeout TO '360s';

CREATE ROLE vkguser_readonly WITH LOGIN PASSWORD 's3cret';
COMMENT ON ROLE vkguser_readonly IS 'Read-only account to access the virtual knowledge graph';
GRANT CONNECT ON DATABASE replica_db TO vkguser_readonly;
GRANT USAGE ON SCHEMA public TO vkguser_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO vkguser_readonly;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO vkguser_readonly;
ALTER ROLE vkguser_readonly SET statement_timeout TO '360s';
```

Let the Subscriber database subscribe to the publication:
```sql
-- run with role vkguser
CREATE SUBSCRIPTION my_subscription
  CONNECTION 'host=original-database-ip-or-url dbname=database-name user=replication_user password=s3cret'
  PUBLICATION my_publication
  WITH (enabled = false);
```
Note that the subscription `my_subscription` must not already exist (otherwise
give it another name). In addition, it should not be enabled when you plan to
add triggers or other mechanisms first, that will perform actions on every CRUD
operation. Start the logical replication afterwards with

```SQL
-- run with role vkguser
ALTER SUBSCRIPTION my_subscription ENABLE;
```

> Limitation of Postgres: The schema must have the same name as on the publication server.

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
