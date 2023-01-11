#!/usr/bin/env bash

# We assume the node is UN at this point

CASSANDRA_NODE_NAME="cassandra-origin-1"

echo -e "\nProvisioning Origin database ...";

sleep 20;

docker cp origin_config/origin_schema.cql "${CASSANDRA_NODE_NAME}":/
docker cp origin_config/origin_populate.cql "${CASSANDRA_NODE_NAME}":/
sleep 2;
docker exec -it "${CASSANDRA_NODE_NAME}" cqlsh -u cassandra -p cassandra -f /origin_schema.cql > ./katapod_logs/cql-origin-schema.log
sleep 5;
docker exec -it "${CASSANDRA_NODE_NAME}" cqlsh -u cassandra -p cassandra -f /origin_populate.cql > ./katapod_logs/cql-origin-populate.log

echo -e "\nOrigin database provisioned.";
