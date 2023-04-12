<!-- TOP -->
<div class="top">
  <img class="scenario-academy-logo" src="https://datastax-academy.github.io/katapod-shared-assets/images/ds-academy-2023.svg" />
  <div class="scenario-title-section">
    <span class="scenario-title">Zero Downtime Migration Lab</span>
    <span class="scenario-subtitle">ℹ️ For technical support, please contact us via <a href="mailto:aleksandr.volochnev@datastax.com">email</a> or <a href="https://dtsx.io/aleks">LinkedIn</a>.</span>
  </div>
</div>

<!-- NAVIGATION -->
<div id="navigation-top" class="navigation-top">
  <a href='command:katapod.loadPage?[{"step":"step2_astra_cli"}]' 
    class="btn btn-dark navigation-top-left">⬅️ Back (astra-cli)
  </a>
  <a href='command:katapod.loadPage?[{"step":"step2_astra_ui"}]' 
    class="btn btn-dark navigation-top-left"
    style="margin-left: 8px;"
  >⬅️ Back (Astra UI)
  </a>
  <span class="step-count">Step 3</span>
  <a href='command:katapod.loadPage?[{"step":"step4"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Phase 1b: Prepare the Ansible container</div>

![Phase 1b](images/p1b.png)

#### _🎯 Goal: having the automation create and start the `zdm-ansible-container`, in which you will then launch the Ansible playbook that provisions and starts the ZDM Proxy._

It's time to download and run `zdm-util`, which creates
the Ansible container that, in turn, will deploy the ZDM proxies.
Download and extract the utility:

```bash
### host
cd /workspace/zdm-scenario-katapod/running_zdm_util
wget https://github.com/datastax/zdm-proxy-automation/releases/download/v2.2.0/zdm-util-linux-amd64-v2.2.0.tgz
tar -xvf zdm-util-linux-amd64-v2.2.0.tgz
rm zdm-util-linux-amd64-v2.2.0.tgz
```

Before going through the configuration utility, you may find it useful to check the IP addresses
you will momentarily need.
For your convenience, this interactive lab provides a handy script that retrieves and prints
exactly that information: execute it (on the still-unused "zdm-proxy-logs" console) with

```bash
### logs
. /workspace/zdm-scenario-katapod/scenario_scripts/find_addresses.sh
```

_Note: in this learning environment we are using a single host for all containers (including Origin!)._
_In a production setup, you would most likely have the proxy containers run each on a separate host machine._

The configuration utility that you are about to launch will ask you a few questions along the way.
Please supply the answers as summarized in this table (see also the [Documentation page](https://docs.datastax.com/en/astra-serverless/docs/migrate/setup-ansible-playbooks.html#_running_the_zdm_utility)):

|Request                              | Answer|
|-------------------------------------|------|
| Private key location                | `../zdm_host_private_key/zdm_deploy_key`     |
| Network prefix for ZDM host         | _If, for example, your ZDM host is_ `172.17.0.1`, _you can provide_ `172.17.0.*` _here_     |
| Do you have an inventory file?      | _No, not yet_     |
| Is this for testing?                | _Yes (so as to allow for a single ZDM host instead of the required three)_     |
| Address for the ZDM hosts           | _the IP for the ZDM host, that is,_ `ZDM_HOST_IP` _in the output of_ `find_addresses.sh`. _There is just one and you have to **input a blank line afterwards** to signal you're done_     |
| Address for the monitoring instance | _The same IP as above for the monitoring instance (in this setup, it will be the same machine)_     |

<details class="katapod-details"><summary>What does the utility do? (click to expand)</summary>

The `zdm-util` interactively collects a few configuration values from the user,
then uses these to create a ready-to-use Ansible Control Host container
tailored to the settings for this specific migration.

The container thus created features Ansible playbooks that you can launch with
simple one-line commands to provision the ZDM Proxies themselves, the associated
monitoring stack, and perform other maintenance operations (such as restarts or
upgrades).

</details>

Start the config utility with:

```bash
### host
cd /workspace/zdm-scenario-katapod/running_zdm_util
./zdm-util-v2.2.0
```

Once you are done, answer "Yes" when asked "Do you wish to proceed?": a `zdm-ansible-container` is created and started
on the host machine's Docker (this will take ten seconds or so).
Once you get the prompt back, check with

```bash
### host
docker ps
```

#### _🗒️ The container is now all set to deploy the ZDM host(s) for you, which will then be ready to accept the connections currently directed at Origin cluster. Ready to deploy the hosts?_

<!-- NAVIGATION -->
<div id="navigation-top" class="navigation-top">
  <a href='command:katapod.loadPage?[{"step":"step2_astra_cli"}]' 
    class="btn btn-dark navigation-top-left">⬅️ Back (astra-cli)
  </a>
  <a href='command:katapod.loadPage?[{"step":"step2_astra_ui"}]' 
    class="btn btn-dark navigation-top-left"
    style="margin-left: 8px;"
  >⬅️ Back (Astra UI)
  </a>
  <a href='command:katapod.loadPage?[{"step":"step4"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>
