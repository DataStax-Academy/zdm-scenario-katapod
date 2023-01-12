#!/usr/bin/env bash

SLEEP_TIME="5"
CASSANDRA_NODE_NAME="cassandra-origin-1"
TARGET_UN_NODE_COUNT="1"
# ADDITIONAL_SLEEP_TIME_UNITS_AT_END="4";
FINAL_SLEEP_TIME="2"

echo -en "> Cassandra is starting up ... ";

# waiting for node to become UN
while true; do
  echo -n "*";
  sleep "${SLEEP_TIME}";
  UN_NODE_COUNT=`docker exec -it ${CASSANDRA_NODE_NAME} nodetool status 2>>/dev/null | grep "^UN " | wc -l`;
  if [ "${UN_NODE_COUNT}" -ge "${TARGET_UN_NODE_COUNT}" ]; then
    break;
  fi
done
echo -n " [UN] ";

# waiting for 'cassandra' superuser to be created
while true; do
  echo -n "*";
  sleep "${SLEEP_TIME}";
  SU_CREATED_LINE_COUNT=`docker logs cassandra-origin-1 2>>/dev/null | grep "Created default superuser role 'cassandra'" | wc -l`;
  if [ "${SU_CREATED_LINE_COUNT}" -ge "1" ]; then
    break;
  fi
done
echo -n " [su]";

# for i in `seq 1 ${ADDITIONAL_SLEEP_TIME_UNITS_AT_END}`; do
#   sleep "${SLEEP_TIME}";
#   echo -n "*";
# done

sleep "${FINAL_SLEEP_TIME}";

echo -e " => Startup complete.";
