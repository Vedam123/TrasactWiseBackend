from datetime import  timedelta
# config.py

# Flask configuration
DEBUG = True
SECRET_KEY = "FLASKVEDSECKEY"

# JWT configuration
JWT_SECRET_KEY = "JWTVEDSECKEY"
JWT_ACCESS_TOKEN_EXPIRES = timedelta(seconds=60)

# config.py
APPLICATION_CREDENTIALS = [
    {"userid":"0","username": "kishore", "password": "$2b$12$OjcDyH3BflTBHiiiQ1pVtOwWnxFju6j7EUBG8GWZKeKICVghjeI96"},
    {"userid":"1","username": "admin", "password": "$2b$12$gnuMPXgfBzU4HqpUwFEVBu71oTAPPZfgnW0GCi50R0rsxeleIN042"},
    # Add more username-password pairs as needed the userids must be below 100
]