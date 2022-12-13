#!/usr/bin/env bash

SLEEP_TIME="1"
CASSANDRA_NODE_NAME="cassandra-origin-1"
TARGET_UN_NODE_COUNT="1"

echo -en "Waiting for Cassandra to complete startup ... ";
while true; do
  echo -n "*";
  sleep "${SLEEP_TIME}";
  UN_NODE_COUNT=`docker exec -it ${CASSANDRA_NODE_NAME} nodetool status 2>>/dev/null | grep "^UN " | wc -l`;
  if [ "${UN_NODE_COUNT}" -ge "${TARGET_UN_NODE_COUNT}" ]; then
    break;
  fi
done

sleep 2;

echo -e "\nCassandra fully started and operational.";
