1. Install Git-2.47.1.2-64-bit first and set path
2. Install mysql-installer-community-8.0.41.0 and set path
3. Install node-v22.14.0-x64 and set path
4. Install python-3.13.2-amd64 and set path

1.Before starting the original config file in the start folder should be updated with the my public IP
DB_SERVER_HOST_IP=172.31.41.61
APP_SERVER_HOST=172.31.41.61
SMTP_HOST=172.31.41.61'

2.Also ensure the 
CERT_ABS_PATH1 = "C:\\SAS Opera\\Companies\\Company_1\\system\\application\\AppService\\certs\\server.crt"
KEY_ABS_PATH1 = "C:\\SAS Opera\\Companies\\Company_1\\system\\application\\AppService\\certs\\server.key"

The Company folder is properly updated to the above in config.py file

Before running any builds , please check 
REACT_APP_BACKEND_SERVER_HOST=16.171.19.177 is with public IP in .env file of webclient


Here are the Paths I set 
1. GIT
	C:\Program Files\Git\cmd

2. MYSQL
	C:\Program Files\MySQL\MySQL Server 8.0\bin
	C:\Program Files\MySQL\MySQL Shell 8.0\bin

3. NODE
	C:\Program Files\nodejs\
	C:\ProgramData\chocolatey\bin
4. python 
	C:\Users\Administrator\AppData\Local\Programs\Python\Python313\
	C:\Users\Administrator\AppData\Local\Programs\Python\Python313\Scripts\
	C:\Python313\Scripts\
	C:\Python313\
	
5. Check the versions with the following commands
	git --version
	mysql --version
	mysqld --version
	node --version
	python --version
	
6. Ensure the npm pm2 is installed globally at the system level
	where pm2 >nul 2>nul
	npm install -g pm2
7. Ensure installer is installed as well at the system level 
	pyinstaller --version >nul 2>nul
	pip install pyinstaller
        014_Install_pm2_and_pyinstaller   is the new batch file located in the instance directory to auto install 6, 7 steps.
8. Ensure the security groups are created as below to allow inbound traffic

9. Go to Windows defender firewall and all the ports as below 

10. After eC2 IS launched perform the following 
	Server Manager > Local Server   On the right pane
	Select IE Enhanced Security Configuration Off
	


	
