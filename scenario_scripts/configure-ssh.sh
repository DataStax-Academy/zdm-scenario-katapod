#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive TZ=Europe/London sudo apt install openssh-server -y

sudo sed 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config -i
sudo sed 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config -i
sudo sed 's/#ListenAddress/ListenAddress/' /etc/ssh/sshd_config -i
sudo sed 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config -i

sudo mkdir /root/.ssh
cat /workspace/zdm-scenario-katapod/zdm_host_private_key/zdm_deploy_key.pub | sudo tee -a /root/.ssh/authorized_keys

mkdir /home/gitpod/.ssh
cat /workspace/zdm-scenario-katapod/zdm_host_private_key/zdm_deploy_key.pub | tee -a /home/gitpod/.ssh/authorized_keys

sudo service ssh restart

chmod 400 zdm_host_private_key/zdm_deploy_key
