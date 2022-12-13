<!-- TOP -->
<div class="top">
  <img src="https://datastax-academy.github.io/katapod-shared-assets/images/ds-academy-logo.svg" />
  <div class="scenario-title-section">
    <span class="scenario-title">Zero Downtime Migration Lab</span>
    <span class="scenario-subtitle">ℹ️ For technical support, please contact us via <a href="mailto:aleksandr.volochnev@datastax.com">email</a> or <a href="https://dtsx.io/aleks">LinkedIn</a>.</span>
  </div>
</div>

<!-- NAVIGATION -->
<div id="navigation-top" class="navigation-top">
 <a href='command:katapod.loadPage?[{"step":"step3"}]' 
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count">Step 4</span>
 <a href='command:katapod.loadPage?[{"step":"step5"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Phase 1c: Start the proxy</div>

_🎯 Goal: configuring and starting the Ansible playbook that automates the creation
and deployment of the ZDM proxy on the target machine(s)._

First start a `bash` shell on the `zdm-ansible-container`: this
will be needed a few times in the rest of this lab
(and will be in the "zdm-ansible-console" terminal).

```
### container
docker exec -it zdm-ansible-container bash
```

The prompt on the "zdm-ansible-console" terminal should now
change to something like `ubuntu@4fb20a9b:~$`.
_This terminal will stay in the container until the end._

It is time to configure the settings for the proxy that is
about to be created. To do so, edit file `zdm_proxy_core_config.yml` _on the container_:

```
### container
cd /home/ubuntu/zdm-proxy-automation/
nano ansible/vars/zdm_proxy_core_config.yml
```

You may find it convenient to check the needed IP addresses with:

```
### host
. ./scenario_scripts/find_addresses.sh
```

In the file, uncomment and edit the following entries:

- `origin_username` and `origin_password`: set both to "cassandra" (no quotes);
- `origin_contact_points`: set it to the IP of the Cassandra seed node;
- `origin_port`: set to 9042;
- `target_username` and `target_password`: set to Client ID and Client Secret found in your Astra DB Token;
- `target_astra_db_id` is your Database ID from the Astra DB dashboard;
- `target_astra_token` is the "token" string in your Astra DB Token" (the one starting with `AstraCs:...`).

_(remember to save and exit `nano` with Ctrl-X, Y, Enter)_

You can now run the Ansible playbook that will provision and start the proxy containers in the three proxy hosts: still in the Ansible container, launch the command:

```
### container
cd /home/ubuntu/zdm-proxy-automation/ansible
ansible-playbook deploy_zdm_proxy.yml -i zdm_ansible_inventory
```

This will provision, configure and start the ZDM proxy, one container per instance
(in this exercise there'll be a single instance). Once this is done, you can check a new container is listed in the output of

```
### host
docker ps
```

_🗒️ The ZDM proxy is now up and running, ready to accept
connections just as if it were a regular Cassandra cluster.
But before doing that, let's think about observability!_

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"step3"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
 <a href='command:katapod.loadPage?[{"step":"step5"}]'
    class="btn btn-dark navigation-bottom-right">Next ➡️
  </a>
</div>
