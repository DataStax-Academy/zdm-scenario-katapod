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
 <a href='command:katapod.loadPage?[{"step":"step4"}]' 
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count">Step 5</span>
 <a href='command:katapod.loadPage?[{"step":"step6"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Phase 1d: Start the monitoring stack</div>

_🎯 Goal: having the Ansible automation provision and start the monitoring stack
associated to the ZDM proxy._

The `zdm-ansible-container` also offers a playbook that installs and starts
a full monitoring stack, which will make Grafana dashboards available for
a detailed view of the performance of the proxy.

Edit file `zdm_monitoring_config.yml` and set the value of `grafana_admin_password` to a memorable password (leaving `grafana_admin_user` to its default of `admin`):

```
### container
cd /home/ubuntu/zdm-proxy-automation/ansible
nano vars/zdm_monitoring_config.yml
```

You can now launch the playbook that sets up the monitoring stack:

```
### container
cd /home/ubuntu/zdm-proxy-automation/ansible
ansible-playbook deploy_zdm_monitoring.yml -i zdm_ansible_inventory
```

When the execution has completed, there will be a Grafana instance
waiting for you on port 3000: you can open it in a new browser tab
with the command _(specific to this learning environment)_:

```
### host
# PLEASE CHECK YOUR POPUP BLOCKER ONCE YOU RUN THIS!
gp preview --external `gp url 3000`
```

Log in with user `admin` and the password you chose,
then go to Dashboards/Manage and pick e.g.
the "ZDM Proxy Dashboard v1" to confirm the datapoints for the plots
are pouring in.

_🗒️ You can now keep the functioning and performance of the proxy
completely under control thanks to a set of Grafana dashboards.
The time has come to make your client application talk to the proxy!_

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"step4"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
 <a href='command:katapod.loadPage?[{"step":"step6"}]'
    class="btn btn-dark navigation-bottom-right">Next ➡️
  </a>
</div>
