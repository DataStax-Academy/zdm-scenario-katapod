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
 <a href='command:katapod.loadPage?[{"step":"step7"}]' 
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count">Step 8</span>
 <a href='command:katapod.loadPage?[{"step":"step9"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Phase 3: enable asynchronous dual reads</div>

![Phase 3](images/p3.png)

#### _🎯 Goal: putting Target to test by having the ZDM Proxy forward all read requests to it as well._

So far, the ZDM Proxy has duplicated only the _write_ statements,
so as to ensure continued equivalence between the contents of
the two databases.

By enabling asynchronous dual reads, you can subject
Target to the same read workload as Origin, thereby verifying its performance
in a realistic production setting. These reads, however,
are issued asynchronously by the proxy, so as not to affect the actual
performance your users will experience.

It is desirable to keep an eye on the proxy logs during
configuration updates and restarts.
Even if, in this lab setup, the proxy container actually runs on the host machine itself, let's go through the motions of a real ZDM deployment, that is, first ssh to "the proxy host" and once there inspect the logs of the Docker container where the proxy is running. Run the following in the "zdm-proxy-logs" console:

```bash
### logs
. /workspace/zdm-scenario-katapod/scenario_scripts/find_addresses.sh
ssh \
  -i /workspace/zdm-scenario-katapod/zdm_host_private_key/zdm_deploy_key \
  gitpod@${ZDM_HOST_IP} -o StrictHostKeyChecking=no
```

You are now logged on to the ZDM Proxy host. Have Docker print
the logs from the proxy container (in a non-stop fashion):

```bash
### logs
docker logs -f zdm-proxy-container
```

Now get to the console running in the ZDM Ansible container (`zdm-ansible-console`): you will have to alter
the proxy settings and issue a "rolling update" of the proxy machines (a notional
concept in this case, since there is a single proxy, but that's the idea).

First open the `zdm_proxy_core_config.yml` configuration:

```bash
### container
cd /home/ubuntu/zdm-proxy-automation/ansible
nano vars/zdm_proxy_core_config.yml
```

_Note: `nano` might occasionally fail to start. In that case, hitting Ctrl-C in the console and re-launching the command would help._

Locate the `read_mode` line (in the `READ ROUTING CONFIGURATION` section)
and change its value from `PRIMARY_ONLY` to `DUAL_ASYNC_ON_SECONDARY`.
Save and exit the editor (`Ctrl-X`, then `Y`, then `Enter`).
_The variables in this file configure how the proxy behaves: these will be changed as you progress through the remaining phases of the migration._

Now perform a rolling update with:

```bash
### container
cd /home/ubuntu/zdm-proxy-automation/ansible/
ansible-playbook rolling_update_zdm_proxy.yml -i zdm_ansible_inventory
```

**Note**: you may see the API issue a (recoverable) error
if it happens to receive a
write request during the (minimal) time with unavailable proxy. Don't worry:
in a real production setup **you would have several proxies** and the drivers
powering your client application would not even flinch at them undergoing
a rolling restart.

Meanwhile, keep an eye on the logs from the container:
they will stop.
Restart the `docker logs` command,

```bash
### {"terminalId": "logs", "macrosBefore": ["ctrl_c"]}
# A Ctrl-C to stop the logs (in case they're still running) ...
# Then we start them again:
docker logs -f zdm-proxy-container
```

and look for a very long line (it's one of the first being written)
containing something like

```
### {"execute": false}
time="2022-[... ...] ,\"ReadMode\":\"DUAL_ASYNC_ON_SECONDARY\" [... ...]
```

Note the `ReadMode: DUAL_ASYNC_ON_SECONDARY` part in the above output.

If you want, check that the application still works by looking for the latest
(timestamped) rows being inserted in the output of:

```bash
### host
curl -s -XGET "localhost:8000/status/eva?entries=2" | jq -r '.[] | "\(.when)\t\(.status)"'
```

#### _🗒️ The two databases are now guaranteed to be identical not only in their content, but also in the requests they get (including read requests). The next step is to elect Target to the role of primary database._

![Schema, phase 3](images/schema3_r.png)

#### 🔎 Monitoring suggestion

With asynchronous dual reads turned on,
you can go to the Grafana dashboard and check
the behaviour of Target: in particular, if you scroll down in the
"ZDM Proxy Dashboard", you'll see that a whole "Async Read Request Metrics"
section is available: looking at it, any performance problem would be promptly
spotted and diagnosed.

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"step7"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
 <a href='command:katapod.loadPage?[{"step":"step9"}]'
    class="btn btn-dark navigation-bottom-right">Next ➡️
  </a>
</div>
