-- Prepare origin schema

CREATE KEYSPACE IF NOT EXISTS my_application_ks WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE my_application_ks;

CREATE TABLE user_status (
  user    TEXT,
  when    TIMESTAMP,
  status  TEXT,
  PRIMARY KEY ((user), when)
) WITH CLUSTERING ORDER BY (when DESC);
