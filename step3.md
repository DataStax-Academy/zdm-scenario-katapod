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
 <a href='command:katapod.loadPage?[{"step":"step2"}]' 
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count">Step 3</span>
 <a href='command:katapod.loadPage?[{"step":"step4"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Phase 1b: Prepare the Ansible container</div>

_Goal: have the automation create and start the `zdm-ansible-container`, in which you will then launch the Ansible playbook that provisions and starts the ZDM proxy._

Time to download and run `zdm-util`, which creates the Ansible container which will then deploy the ZDM proxies. Download and extract the utility:

```
### host
cd /workspace/zdm-scenario-katapod/running_zdm_util
wget https://github.com/datastax/zdm-proxy-automation/releases/download/v2.0.3/zdm-util-linux-amd64-v2.0.3.tgz
tar -xvf zdm-util-linux-amd64-v2.0.3.tgz
rm zdm-util-linux-amd64-v2.0.3.tgz
```

Next, start the utility. It will ask you a few questions:

- the private key location: it is `../zdm_host_private_key/zdm_deploy_key`;
- the network prefix for the ZDM host: if, for example, your ZDM host is `172.17.0.1`, you can provide `172.17.0.*` here;
- no, you don't have an inventory file yet;
- yes, this is for testing (so as to allow for a single ZDM host instead of the required three);
- enter the IP for the ZDM host;
- enter the same IP as above for the monitoring instance (in this setup, it will be the same machine).

You may find it convenient to check the IP addresses with:

```
### host
. ../scenario_scripts/find_addresses.sh
```

Then, start the utility with:

```
### host
./zdm-util-v2.0.3
```

Once you are done with the answers, a `zdm-ansible-container` is created and started
on the host machine's Docker. Check with

```
### host
cd ..
docker ps
```

_The container can deploy the ZDM host(s) for you. The host(s) will be ready to accept connections instead of the Origin cluster. Ready to deploy the hosts?_

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"step2"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
 <a href='command:katapod.loadPage?[{"step":"step4"}]'
    class="btn btn-dark navigation-bottom-right">Next ➡️
  </a>
</div>
