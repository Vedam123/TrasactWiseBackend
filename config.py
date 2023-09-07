from datetime import  timedelta
# config.py

# Flask configuration
DEBUG = True
SECRET_KEY = "FLASKVEDSECKEY"

# JWT configuration
JWT_SECRET_KEY = "JWTVEDSECKEY"
#JWT_ACCESS_TOKEN_EXPIRES = timedelta(seconds=3600)
JWT_ACCESS_TOKEN_EXPIRES = timedelta(minutes=30)
JWT_REFRESH_TOKEN_EXPIRES = timedelta(days=7)

# config.py
APPLICATION_CREDENTIALS = [
    {"userid":"0","username": "kishore", "name":"SUPER USER0" , "password": "$2b$12$OjcDyH3BflTBHiiiQ1pVtOwWnxFju6j7EUBG8GWZKeKICVghjeI96"},
    {"userid":"1","username": "admin", "name":"SUPER USER1" ,"password": "$2b$12$gnuMPXgfBzU4HqpUwFEVBu71oTAPPZfgnW0GCi50R0rsxeleIN042"},
   #{"userid":"100-MAX value","username": "admin", "name":"SUPER USER1" ,"password": "$2b$12$gnuMPXgfBzU4HqpUwFEVBu71oTAPPZfgnW0GCi50R0rsxeleIN042"}   
    # Add more username-password pairs as needed the userids must be below 100. This count should match with the SUPER_USERS_COUNT in application
]