<!-- TOP -->
<div class="top">
  <img src="https://datastax-academy.github.io/katapod-shared-assets/images/ds-academy-logo.svg" />
  <div class="scenario-title-section">
    <span class="scenario-title">Zero Downtime Migration Lab</span>
    <span class="scenario-subtitle">ℹ️ For technical support, please contact us via <a href="mailto:aleksandr.volochnev@datastax.com">email</a> or <a href="https://dtsx.io/aleks">LinkedIn</a>.</span>
  </div>
</div>

<!-- CONTENT -->
<main>
    <br/>
    <div class="container px-4 py-2">
      <div class="row g-4 py-2 row-cols-1 row-cols-lg-1">
        <div class="feature col div-choice">
          <div class="scenario-description">An interactive Zero Downtime Migration (ZDM) hands-on lab</div>
          <ul>
            <li><span class="scenario-description-attribute">Difficulty</span>: Advanced</li>
            <li><span class="scenario-description-attribute">Duration</span>: 80 minutes</li>
          </ul>
        </div>
      </div>
      <div class="row g-4 py-2 row-cols-1 row-cols-lg-1">
        <div class="feature col div-choice">
          <div class="scenario-description">
            <strong>Outline of this lab:</strong>
          </div>
          <div class="scenario-description">
            <p>
              <img src="https://raw.githubusercontent.com/hemidactylus/zdm-scenario-katapod/main/images/pz_annotated.png" />
            </p>
          </div>
          <div class="scenario-description-attribute">
            <p>
              This is a guided end-to-end Zero-Downtime-Migration hands-on experience
              designed to run entirely in your browser. You will start with a running client application
              backed by a Cassandra installation, and will go through all steps required
              to migrate it to an Astra DB instance/
            </p>
            <p>
              This interactive lab is designed after the phases described in detail in the ZDM Documentation pages,
              which is a recommended reading before starting a migration in production.
            </p>
            <p><strong>The migration is structured in five phases:</strong></p>
            <ul>
              <li>
                <strong>Phase 1:</strong>
                Connect your client applications to the ZDM Proxy. This activates the dual-write logic: writes will be "bifurcated" (sent both to Origin and Target), while reads will be executed on Origin only.
              </li>
              <li>
                <strong>Phase 2:</strong>
                Migrate existing data using Cassandra Data Migrator and/or DSBulk Migrator. Validate that the migrated data is correct, while continuing to perform dual writes.
              </li>
              <li>
                <strong>Phase 3:</strong>
                Enable asynchronous dual reads (optional).
              </li>
              <li>
                <strong>Phase 4:</strong>
                Change the proxy configuration to route reads to Target, effectively using Target as the source-of-truth while still keeping Origin in sync.
              </li>
              <li>
                <strong>Phase 5:</strong>
                Move your client applications off the ZDM Proxy and connect them directly to Target.
              </li>
            </ul>
            <p>
              <strong>About Origin and the client application:</strong>
              In this lab, the Origin database is a Cassandra single-node cluster running locally, which is being
              provisioned while you are reading this.
              The lab provides a simple client application, a HTTP REST API used to read and write
              the "status" of "users" (e.g. <i>Away, Busy, Online</i>).
              Even though during the lab you will query the API just to get the latest values,
              reading straight from the DB you will be able to see the whole history of user status changes.
              The application will initially connect to Origin, but is ready to adapt to the migration phases
              with a simple restart, provided you will have inserted the required connection parameters in a
              configuration file.
            </p>
            <details><summary>Click to see how this learning environment differs from a real migration</summary>
              <p>
                <i>
                  This is an ephemeral setup, designed to be bootstrapped quickly and in such a way as to be easily packaged into a single host machine. As a consequence, please mind that:
                </i>
                <ul>
                  <li>
                    you will have a single ZDM Proxy instance (as opposed to at least three as suggested for production migrations);
                  </li>
                  <li>
                    All containers (including Origin!) will be running on a single machine. In a realistic setup this would put resiliency and availability at risk, and certainly hinder performance and throughput.
                  </li>
                </ul>
              </p>
            </details>
          </div>
        </div>
      </div>
      <div class="row g-4 py-2 row-cols-1 row-cols-lg-1">
        <div class="feature col div-choice">
          <div class="scenario-description">References:</div>
          <ul>
            <li><span class="scenario-description-attribute"><a href="https://docs.datastax.com/en/astra-serverless/docs/migrate/introduction.html" target="_blank">Datastax ZDM documentation</a></span></li>
            <li><span class="scenario-description-attribute"><a href="https://astra.datastax.com/" target="_blank">Astra DB</a></span></li>
          </ul>
        </div>
      </div>
    </div>
</main>

<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"step1"}]'
    class="btn btn-dark navigation-bottom-right">Start ➡️
  </a>
</div>
