import os
import datetime

from fastapi import FastAPI, Depends
from pydantic import BaseModel

from db_connection import get_session

session_mode = os.environ['CLIENT_CONNECTION_MODE']
print(f'\n\n*** API loading with mode = {session_mode} ***\n')

# Helpers
#   (this part, in a well-structured app, would go to separate modules...)

async def get_db_session():
    # this wraps getting the session in a way that works with the Depends injection
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
