#!/usr/bin/env bash

docker exec zdm-ansible-container sed -i 's/ansible_user=ubuntu/ansible_user=gitpod/' /home/ubuntu/zdm-proxy-automation/ansible/zdm_ansible_inventory;

docker exec zdm-ansible-container sed 's/home\/ubuntu/home\/gitpod/' /home/ubuntu/zdm-proxy-automation/ansible/vars/zdm_playbook_internal_config.yml -i;
docker exec zdm-ansible-container sed 's/_user_name: ubuntu/_user_name: gitpod/' /home/ubuntu/zdm-proxy-automation/ansible/vars/zdm_playbook_internal_config.yml -i;

docker exec zdm-ansible-container sed "s/hostvars\[inventory_hostname\]\['ansible_default_ipv4'\]\['address'\]/inventory_hostname/" /home/ubuntu/zdm-proxy-automation/ansible/templates/zdm_proxy_immutable_config_file.j2 -i;
docker exec zdm-ansible-container sed "s/hostvars\[inventory_hostname\]\['ansible_default_ipv4'\]\['address'\]/inventory_hostname/" /home/ubuntu/zdm-proxy-automation/ansible/templates/zdm_proxy_immutable_config_env_vars.j2 -i;

docker exec zdm-ansible-container sed "s/hostvars\[inventory_hostname\]\['ansible_default_ipv4'\]\['address'\]/inventory_hostname/" /home/ubuntu/zdm-proxy-automation/ansible/deploy_zdm_proxy.yml -i;

docker exec zdm-ansible-container sed "s/hostvars\[inventory_hostname\]\['ansible_default_ipv4'\]\['address'\]/inventory_hostname/" /home/ubuntu/zdm-proxy-automation/ansible/rolling_update_zdm_proxy.yml -i;

docker exec zdm-ansible-container sed "s/hostvars\[inventory_hostname\]\['ansible_default_ipv4'\]\['address'\]/inventory_hostname/" /home/ubuntu/zdm-proxy-automation/ansible/rolling_restart_zdm_proxy.yml -i;

clear;
