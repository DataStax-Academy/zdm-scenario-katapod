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
 <a href='command:katapod.loadPage?[{"step":"intro"}]' 
   class="btn btn-dark navigation-top-left">⬅️ Back
 </a>
<span class="step-count"> Step 1 of 2</span>
 <a href='command:katapod.loadPage?[{"step":"step2"}]' 
    class="btn btn-dark navigation-top-right">Next ➡️
  </a>
</div>

<!-- CONTENT -->

<div class="step-title">Before the migration</div>

Check Origin:

```
### host
docker exec \
  -it cassandra-origin-1 \
  cqlsh -u cassandra -p cassandra \
  -e "select * from my_application_ks.user_status where user='eva';"
```

It is now time to prepare your dotenv file to feed secrets and connection
parameters to the sample application (a simple REST API in our case).

To do so, first check the addresses you need by running:

```
### host
. ./scenario_scripts/find_addresses.sh
```

Now copy the provided template and edit it, inserting, for the time being,
just the IP address of the Cassandra (Origin) seed
_(Note: to save the file and quit `nano` once modified: Ctrl-X, then Y, then Enter)_:

```
### api
cd client_application
cp .env.sample .env
nano .env
```

Run the API in such a way that it reads from Origin:

```
### api
CLIENT_CONNECTION_MODE=CASSANDRA uvicorn api:app
```

Test the API with a few calls: first check Eva's status with:

```
### client
curl -XGET localhost:8000/status/eva | jq -r '.[].status'
```

Then write a new status:

```
### client
curl -XPOST localhost:8000/status/eva/New | jq
```

Try the read now (click the `GET` command again):

Now start a loop that periodically inserts a new status

```
### client
while true; do
  NEW_STATUS="ItIs_`date +'%H-%M-%S'`";
  echo -n "Setting status to ${NEW_STATUS} ... ";
  curl -s -XPOST -o /dev/null "localhost:8000/status/eva/${NEW_STATUS}";
  echo "done. Sleeping a little ... ";
  sleep 20;
done
```


<!-- NAVIGATION -->
<div id="navigation-bottom" class="navigation-bottom">
 <a href='command:katapod.loadPage?[{"step":"intro"}]'
   class="btn btn-dark navigation-bottom-left">⬅️ Back
 </a>
 <a href='command:katapod.loadPage?[{"step":"step2"}]'
    class="btn btn-dark navigation-bottom-right">Next ➡️
  </a>
</div>


