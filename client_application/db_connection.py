import os
import atexit

from dotenv import load_dotenv
from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider


# read .env file for connection params
load_dotenv()
#
ASTRA_DB_SECURE_BUNDLE_PATH = os.environ['ASTRA_DB_SECURE_BUNDLE_PATH']
ASTRA_DB_CLIENT_ID = os.environ['ASTRA_DB_CLIENT_ID']
ASTRA_DB_CLIENT_SECRET = os.environ['ASTRA_DB_CLIENT_SECRET']
#
CASSANDRA_SEED = os.environ['CASSANDRA_SEED']
CASSANDRA_USERNAME = os.environ['CASSANDRA_USERNAME']
CASSANDRA_PASSWORD = os.environ['CASSANDRA_PASSWORD']
#
KEYSPACE_NAME = os.environ['KEYSPACE_NAME']
#
ZDM_PROXY_SEED = os.environ['ZDM_PROXY_SEED']


# global cache variables to re-use a single Session (per mode)
cluster_map = {}
session_map = {}


def get_session(mode):
    """
    'mode' can be 'CASSANDRA', 'ASTRA_DB' or 'ZDM_PROXY' here.
    """
    global session_map
    global cluster_map
    #
    session = session_map.get(mode)
    if session is None:
        print(f'[get_session] Creating session (mode={mode})')
        if mode == 'CASSANDRA':
            cluster = Cluster(
                [CASSANDRA_SEED],
                auth_provider=PlainTextAuthProvider(
                    CASSANDRA_USERNAME,
                    CASSANDRA_PASSWORD,
                ),
            )
            session = cluster.connect(KEYSPACE_NAME)
        elif mode == 'ASTRA_DB':
            cluster = Cluster(
                cloud={
                    'secure_connect_bundle': ASTRA_DB_SECURE_BUNDLE_PATH,
                },
                auth_provider=PlainTextAuthProvider(
                    ASTRA_DB_CLIENT_ID,
                    ASTRA_DB_CLIENT_SECRET,
                ),
            )
            session = cluster.connect(KEYSPACE_NAME)
        elif mode == 'ZDM_PROXY':
            cluster = Cluster(
                [ZDM_PROXY_SEED],
                auth_provider=PlainTextAuthProvider(
                    ASTRA_DB_CLIENT_ID,
                    ASTRA_DB_CLIENT_SECRET,
                ),
            )
            session = cluster.connect(KEYSPACE_NAME)
        else:
            raise ValueError(f'Unknown session mode {mode}')
        #
        cluster_map[mode] = cluster
        session_map[mode] = session
    else:
        print(f'[get_session] Reusing session (mode={mode})')
    #
    return session


@atexit.register
def shutdown_driver():
    for mode, session in session_map.items():
        if session is not None:
            print(f'[shutdown_driver] Closing connection (mode={mode})')
            cluster_map[mode].shutdown()
            session.shutdown()
