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
 <a href='command:katapod.loadPage?[{"step":"step1"}]' 
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count">Step 2</span>
 <a href='command:katapod.loadPage?[{"step":"step3"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Phase 1a: Set up Target</div>

_🎯 Goal: creating the Target database (Astra DB instance) and verifying
it is ready for the migration._

- Create an Astra DB instance with a keyspace named `my_application_ks`.
- Get a "R/W User" token from the Astra UI and store it in a safe place. _You will need it a few times throughout the exercise._
- Retrieve the "Database ID" for your Astra DB instance.
- Find the "download secure-connect-bundle" option in the Connect tab of your Astra DB instance and paste the `curl` command you get there in the "host" console here. Take a note of the full path to the bundle zipfile.
- In the Web CQL Console on the Astra UI, paste the following script to create a schema that mirrors the one on Origin:

```
### {"execute": false}
CREATE TABLE IF NOT EXISTS my_application_ks.user_status (
  user    TEXT,
  when    TIMESTAMP,
  status  TEXT,
  PRIMARY KEY ((user), when)
) WITH CLUSTERING ORDER BY (when DESC);
```

_Note: the steps above could be better automated with the use of `astra-cli`.
Support for it in the instructions, either alongside or instead of the "UI way",
will be added._

_🗒️ Your brand new database is created and has the right schema.
Now you can start setting up the ZDM process, instructing it to use Astra DB as target._

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"step1"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
 <a href='command:katapod.loadPage?[{"step":"step3"}]'
    class="btn btn-dark navigation-bottom-right">Next ➡️
  </a>
</div>
