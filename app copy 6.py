import os
import sys
import time
import logging
import configparser
import servicemanager
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

def run_flask():
    try:
        register_blueprints(app)
        logger.info("Starting Flask without SSL for testing.")
        app.run(debug=True, host=APP_SERVER_HOST, port=APP_SERVER_PORT, use_reloader=False)
    except Exception as e:
        logger.error(f"Error while starting Flask: {str(e)}")

class MyCustomPythonService(win32serviceutil.ServiceFramework):
    _svc_name_ = f"{APP_SERVICE_NAME}_flask"
    _svc_display_name_ = f"{APP_SERVICE_DISP_NAME}_flask"

    def __init__(self, args):
        logger.info("Running __init__ function .")
        win32serviceutil.ServiceFramework.__init__(self, args)
        self.hWaitStop = win32event.CreateEvent(None, 0, 0, None)
        logger.debug(f"Service {self._svc_name_} initialized")

    def SvcStop(self):
        logger.info("Running SvcStop function .")        
        self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
        logger.debug(f"Stopping service {self._svc_name_}...")
        if self.flask_thread:
            logger.debug(f"Joining flask thread...")
            self.flask_thread.join()  # Ensure Flask shuts down gracefully
        win32event.SetEvent(self.hWaitStop)
        logger.debug(f"Service {self._svc_name_} stopped")

    def SvcDoRun(self):
        logger.info("Running SvcDoRun function .")
        try:
            status = win32serviceutil.QueryServiceStatus(self._svc_name_)
            logger.debug(f"Service status: {status}")
        except Exception as e:
            logger.error(f"Service {self._svc_name_} not found: {str(e)}")
            logger.info(f"Attempting to install service {self._svc_name_}...")
            try:
                win32serviceutil.InstallService(
                    python_exe=sys.executable,  
                    args=[sys.argv[0]]  
                )
                logger.info(f"Service {self._svc_name_} installed successfully.")
            except Exception as install_error:
                logger.error(f"Failed to install service {self._svc_name_}: {str(install_error)}")
                return

        self.ReportServiceStatus(win32service.SERVICE_RUNNING)
        logger.debug(f"Starting service {self._svc_name_}...")
        
        # Start Flask in a separate thread
        self.flask_thread = Thread(target=run_flask)
        self.flask_thread.start()

        logger.debug(f"Service {self._svc_name_} started successfully")

if __name__ == '__main__':
    app.config['DEBUG'] = True
    logger.debug(f"Starting service {APP_SERVICE_NAME}_flask...")

    MyCustomPythonService._svc_name_ = f"{APP_SERVICE_NAME}_flask"
    MyCustomPythonService._svc_display_name_ = f"{APP_SERVICE_DISP_NAME}_flask"

    win32serviceutil.HandleCommandLine(MyCustomPythonService)
