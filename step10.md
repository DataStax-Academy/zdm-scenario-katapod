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
 <a href='command:katapod.loadPage?[{"step":"step9"}]' 
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count">Step 10</span>
 <a href='command:katapod.loadPage?[{"step":"cleanup"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Phase 5: connect directly to Target</div>

![Phase 5](images/p5.png)

_🎯 Goal: instructing your client application to connect directly to Target,
in order to later dispose of the whole ZDM infrastructure._

Until now we could bail out any time.
After the following change **we are effectively committing to the migration**,
with the app directly writing to Astra DB and finally
skipping the ZDM (and Origin) altogether.

This step is very simple. The following command stops the running API, then
restarts it by passing it the appropriate setting:

```bash
### {"terminalId": "api", "macrosBefore": ["ctrl_c"]}
# A Ctrl-C to stop the running process ... followed by:
CLIENT_CONNECTION_MODE=ASTRA_DB uvicorn api:app
```

The API will work exactly as before and the migration is complete.
At this point, you can destroy the whole ZDM infrastructure (see next step).

The loop is still periodically writing new rows: to ensure
the application is still working as expected, you can launch yet
another read request:

```bash
### host
curl -XGET localhost:8000/status/eva | jq -r '.[].status'
```

_🏆 Congratulations: the migration is complete. You managed to perform
a Zero Downtime Migration, making sure all data (past and present)
is kept consistent, with the ability to keep read performance
under scrutiny at all times, and a full suite of dashboards to inspect
every aspect of the migration process. The only thing left to do
is cleaning up: hit "Next" to complete this exercise._

![Schema, phase 5](images/schema5_r.png)

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"step9"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
 <a href='command:katapod.loadPage?[{"step":"cleanup"}]'
    class="btn btn-dark navigation-bottom-right">Next ➡️
  </a>
</div>
