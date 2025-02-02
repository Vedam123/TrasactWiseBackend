import os
import sys
import time
import logging
import configparser
import win32serviceutil
import win32service
import win32event
from threading import Thread
from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from blueprints import register_blueprints
from config import JWT_SECRET_KEY, JWT_ACCESS_TOKEN_EXPIRES, APP_SERVER_HOST, APP_SERVER_PORT, SSL_CRT_FILE, SSL_KEY_FILE, APP_SERVICE_NAME, APP_SERVICE_DISP_NAME

# Setup logging to a file and console
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger()

APP_SERVER_PORT = int(APP_SERVER_PORT)

app = Flask(__name__)
CORS(app)

app.config["JWT_SECRET_KEY"] = JWT_SECRET_KEY
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = JWT_ACCESS_TOKEN_EXPIRES
jwt = JWTManager(app)

register_blueprints(app)

def run_flask():
    try:
        logger.info("Starting Flask without SSL for testing.")
        app.run(debug=True, host=APP_SERVER_HOST, port=APP_SERVER_PORT, use_reloader=False)
    except Exception as e:
        logger.error(f"Error while starting Flask: {str(e)}")

class MyCustomPythonService(win32serviceutil.ServiceFramework):
    _svc_name_ = APP_SERVICE_NAME
    _svc_display_name_ = APP_SERVICE_DISP_NAME

    def __init__(self, args):
        win32serviceutil.ServiceFramework.__init__(self, args)
        self.hWaitStop = win32event.CreateEvent(None, 0, 0, None)
        self.flask_thread = None
        logger.debug(f"Service {self._svc_name_} initialized")

    def SvcStop(self):
        self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
        if self.flask_thread:
            logger.debug("Stopping Flask thread...")
            self.flask_thread.join()  # Wait for the Flask app thread to complete
        win32event.SetEvent(self.hWaitStop)
        logger.debug("Service stopped")

    def SvcDoRun(self):
        # Check if the service is already installed
        try:
            status = win32serviceutil.QueryServiceStatus(self._svc_name_)
            logger.debug(f"Service status: {status}")
        except Exception as e:
            logger.error(f"Service not found: {str(e)}")
            logger.info(f"Attempting to install {self._svc_name_}...")

            # Install the service if not already installed
            win32serviceutil.InstallService(
                python_exe=sys.executable,  # Path to the Python executable
                args=[sys.argv[0]]  # Path to the script
            )
            logger.info(f"Service {self._svc_name_} installed successfully.")
            return

        self.ReportServiceStatus(win32service.SERVICE_RUNNING)
        logger.debug("Service running... starting Flask app in thread")

        # Start Flask app in a new thread
        self.flask_thread = Thread(target=run_flask)
        self.flask_thread.start()

        # Wait for the Flask app to initialize properly
        timeout = 120  # Allow up to 120 seconds for Flask to start
        elapsed_time = 0

        while elapsed_time < timeout:
            if self.flask_thread.is_alive():
                logger.debug("Flask app is running.")
                break
            time.sleep(1)
            elapsed_time += 1
            logger.debug(f"Waiting for Flask to start... ({elapsed_time}/{timeout} seconds)")

        # If the Flask app didn't start within the timeout, log an error
        if elapsed_time >= timeout:
            logger.error("Flask app did not start in time. Service startup failed.")
            self.ReportServiceStatus(win32service.SERVICE_STOPPED)
            return

        logger.debug(f"Service {self._svc_name_} started successfully")
        
        # Keep the service alive
        while True:
            time.sleep(30)

if __name__ == '__main__':
    app.config['DEBUG'] = True
    logger.debug(f"Starting {APP_SERVICE_NAME}...")

    MyCustomPythonService._svc_name_ = APP_SERVICE_NAME
    MyCustomPythonService._svc_display_name_ = APP_SERVICE_DISP_NAME

    win32serviceutil.HandleCommandLine(MyCustomPythonService)
