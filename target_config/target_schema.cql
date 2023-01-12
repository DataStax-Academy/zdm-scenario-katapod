USE zdmapp;

CREATE TABLE IF NOT EXISTS user_status (
  user    TEXT,
  when    TIMESTAMP,
  status  TEXT,
  PRIMARY KEY ((user), when)
) WITH CLUSTERING ORDER BY (when DESC);
