#!/usr/bin/env bash

# Before ssh occurs, we add a pip install since for some reason the workaround for
# the "pyenv: command not found" mysteriously causes disappearance of pip-installed uvicorn.
# Feel free to remove both (the other in .gitpod.yml) and live with the puny warning.

sed -i '/\$HOME\/.bashrc.d\//a pip install -r \/workspace\/zdm-scenario-katapod\/client_application\/requirements.txt 2>\&1 >> \/workspace\/zdm-scenario-katapod\/katapod_logs\/pip-install-upon-ssh.log' /home/gitpod/.bashrc ;

clear;
