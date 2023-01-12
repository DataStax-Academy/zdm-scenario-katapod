#!/usr/bin/env bash

# Creation of the .env file, pre-filled as far as Origin is concerned

echo -en "> Configuring client application ...";

source ./scenario_scripts/find_addresses.sh >> /dev/null
cat client_application/.env.sample | sed "s/IP.OF.ORIGIN.1/${CASSANDRA_SEED_IP}/" > client_application/.env

echo -e " => done.";
