GLOBAL INSTALLATIONS 
	
	1. Install Git-2.47.1.2-64-bit and set path
	2. Install mysql-installer-community-8.0.41.0 and set path
	3. Install node-v22.14.0-x64 and set path
	4. Install python-3.13.2-amd64 and set path
	5. Install pm2 --> npm install -g pm2
	6. Install pyinstaller --> pip install pyinstaller
	
SET PATHS in windows OS

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

CHECK VERSIONS

	1. Check the versions with the following commands
		git --version
		mysql --version
		mysqld --version
		node --version
		python --version
		pm2 -v
		pyinstaller --version

CHANGES IN CONFIG FILES

	1. Update the following with the public IP of the system like below in the config.ini file which is in start\Company_3 directory path
			DB_SERVER_HOST_IP=172.31.41.61
			APP_SERVER_HOST=172.31.41.61
			SMTP_HOST=172.31.41.61'



AFTER EC2 is LAUNCHED

	For the below 3 steps refer the document 10_Firewall and Security groups.docx , which contains example screens

	1. Switch off the IE enhanced Security in eC2 Instance
		Navigation : Server Manager > Local Server   On the right pane
					Select IE Enhanced Security Configuration Off
	2. Add Ports to Inbound Rules in eC2 firewall
		Go to Windows defender firewall and all the ports of the company
	3. Check the eC2 Instance Security groups and add all the https ports of that compan

Development Instance setup

	1. copy the Installation Scripts folder to local machine to one of the directory
	2. Open the config.ini file and make changes like company_folder and  WEB_CLIENT_APPLICATION_NAME save it
	3. Run the file Install_dev_system , after close to 30 min later it will generate a results.txt file in the directory Start with all the necessary connection URLs and database details.




