import os
import datetime

from fastapi import FastAPI, Depends

from db_connection import get_session


MODE_FILENAME = 'CLIENT_CONNECTION_MODE'
MODE_ENV_VAR_NAME = 'CLIENT_CONNECTION_MODE'

# Helpers
#   (this part, in a well-structured app, would go to separate modules...)

def get_session_mode():
    """
    a MODE_FILENAME file is checked, containing just the connection mode string:
    if it exists, it has precedence; otherwise, the env var is read.
    """
    if os.path.isfile(MODE_FILENAME):
        """
        If a file is used to switch connection mode, the API can be started as:
            uvicorn api:app
        as long as before the first request one does something like:
            echo CASSANDRA > CLIENT_CONNECTION_MODE
        or
            echo ZDM_PROXY > CLIENT_CONNECTION_MODE
        or
            echo ASTRA_DB > CLIENT_CONNECTION_MODE
        In any time, without having to restart the API, the above
        'echo' commands will let the API know that the next request(s)
        will need to use a certain connection mode.
        """
        s_mode = open(MODE_FILENAME).read().strip()
    else:
        s_mode = os.environ.get(MODE_ENV_VAR_NAME)
    return s_mode


async def get_db_session():
    """
    this wraps the get_session function
    in a way that works with the Depends injection (i.e. as an async iterator)
    """
    session_mode = get_session_mode()
    yield get_session(mode=session_mode)


GET_STATUS_QUERY = 'SELECT * FROM user_status WHERE user=%s LIMIT 3;'
PUT_STATUS_QUERY = 'INSERT INTO user_status (user, when, status) VALUES (%s, %s, %s);'

app = FastAPI()

@app.get('/status/{user}')
async def get_status(user, session=Depends(get_db_session)):
    return [
        {
            'user': status.user,
            'when': status.when,
            'status': status.status,
        }
        for status in session.execute(GET_STATUS_QUERY, (user,) )
    ]

@app.post('/status/{user}/{status}')
async def put_status(user, status, session=Depends(get_db_session)):
    new_status = {
        'user': user,
        'when': datetime.datetime.now(),
        'status': status,
    }
    session.execute(
        PUT_STATUS_QUERY,
        (
            new_status['user'],
            new_status['when'],
            new_status['status'],
        ),
    )
    return new_status
