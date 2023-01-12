#!/usr/bin/env bash

clear ;

./scenario_scripts/welcome.sh ;

./scenario_scripts/wait_for_cassandra.sh ;

./scenario_scripts/provision_origin.sh ;

./scenario_scripts/prepare_app_dotenv.sh ;

echo "" ;
echo "   ╔════════════════════╗" ;
echo "   ║  Ready for Step 1  ║" ;
echo "   ╚════════════════════╝" ;
echo "" ;
