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
  <span class="step-count">Step 2 (astra-cli)</span>
  <a href='command:katapod.loadPage?[{"step":"step3"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Phase 1a: Set up Target</div>

![Phase 1a](images/p1a.png)

#### _🎯 Goal: creating the Target database (Astra DB instance) and verifying it is ready for the migration._

_The Target database you are going to create is an **Astra DB** instance.
This managed solution, built on Apache Cassandra™, frees you from
worrying about operations; moreover, it is a serverless architecture
that scales with your needs, avoiding unnecessary resource usage.
If you don't have an Astra account, [go create one](https://astra.datastax.com/): the **Free Tier**
can cover much, much more I/O and storage than what's needed for
this migration exercise._

**Note**: you are going to make use of the `astra-cli` [utility](https://docs.datastax.com/en/astra-classic/docs/astra-cli/introduction.html)
to perform most of the required steps from the console.
However, database creation and generation of an associated token are still done on the Astra Web UI:

- Create your [Astra account](https://astra.datastax.com/) if you haven't yet.
- Create a database called `zdmtarget` with a `zdmapp` keyspace ([detailed instructions](https://awesome-astra.github.io/docs/pages/astra/create-instance/)). _for the Free Tier accounts, stick to the GCP cloud provider and choose a region without the "lock" icon). The DB will be ready to use in 2-3 minutes._
- Get a "Database Administrator" database token from the Astra UI and store it in a safe place ([detailed instructions](https://awesome-astra.github.io/docs/pages/astra/create-token/#c-procedure)). _You will need it a few times throughout the exercise. For the migration process, a "R/W User" token would suffice, but a more powerful token is needed for the `astra-cli` automation._

Once this part is done, you can proceed in the "host" console.
The Astra CLI is preinstalled for you: configure it with

```bash
### host
astra setup
```

and provide the `AstraCS:...` part of the token when prompted.

Have the CLI prepare a `.env` file, useful to later retrieve the database ID:

```bash
### host
astra db create-dotenv zdmtarget -k zdmapp
```

Next, the CLI will download the "secure connect bundle" zipfile, for use by the sample application.
_Take a note of the full path to the bundle zipfile, you'll need it for the example API_:

```bash
### host
astra db download-scb zdmtarget -f secure-connect-zdmtarget.zip
ls /workspace/zdm-scenario-katapod/*.zip -lh
```

Finally, your Target database needs a schema matching the one in Origin.
Check the contents of the script file with

```bash
### host
cat target_config/target_schema.cql
```

and then execute it on the newly-created Astra DB instance:

```bash
### host
astra db cqlsh zdmtarget -f target_config/target_schema.cql
```

#### _🗒️ Your brand new database is created and has the right schema. Now you can start setting up the ZDM process, instructing it to use Astra DB as target._

![Schema, phase 1a](images/schema1a_r.png)

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
  <a href='command:katapod.loadPage?[{"step":"step1"}]'
    class="btn btn-dark navigation-bottom-left">⬅️ Back
  </a>
  <a href='command:katapod.loadPage?[{"step":"step3"}]'
    class="btn btn-dark navigation-bottom-right">Next ➡️
  </a>
</div>
