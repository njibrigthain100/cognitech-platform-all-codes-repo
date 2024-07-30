	- Jenkins is a very important aspect of DevOps. Jenkins is an open source continuous integration and continuous deployment tool written in Java
	- Platforms where Jenkins can be installed are Linux, windows, MacOS
	- It is a multi-platform tool
	- Jenkins started in 2004 by Oracle. It was called Hudson at the time and the Jenkins community took over the tool in 2011 and it became an open source technology
	- What is Jenks used for? It is used for continuous integration
	- When trying to build a application developers build their code and commit to git.
	- Continuous integration is the ability for Jenkins to connect with all other tools in the CICD pipeline process to help with the CICD process
	- Continuous integration is a development practice where  developers integrate their code into a shared remote repository frequently, preferably several times a day. Each integration is verified by an automated build (including test) to detect integration errors as quickly as possible. 
	- Here all the steps are automated after the code is committed by the developers
	- Continuous delivery 
	- UAT is user acceptance testing
	- Jenkins is configured in such a way that when the developer commits the code to GitHub it ensure that a maven build takes place
	- Maven validates, compiles, test and packages the code
	- The application is first taken to the staging/Testing environment for more testing. Some of the testing are performance, integration, regression and security(Penetration) testing. 
	- So if the package runs well in Dev, we want to run in Pre-prod before moving it to Prod. 
	- Immediately the code is added to GitHub Jenkins triggered a build by connecting with Maven, SonarQube etc
	- Jenkins connects with SonarQube for code quality analysis and connects with Nexus as well
	- Additional testing is performed before code is deployed
	- If testing process is automated then we will achieve continuous deployment
	- If testing is done manually i.e. someone manually giving approval then it is known as continuous delivery and not deployment
	- An example of someone manually approving the testing process ca be the client
	- Internal project in Landmark: In house --> Continuous deployment
	- External projects with clients --> Continuous delivery
	- Difference between continuous deployment and continuous delivery depends on the nature of the applications. Critical projects that usually require robust testing such as government applications have to go through continuous delivery and non-critical applications go through continuous deployment
	- Jenkins comes as community edition (free) and enterprise edition which is not free. Enterprise version is called cloud based version
INSTALLING JENKINS
	- https://www.redhat.com/sysadmin/install-jenkins-rhel8
	- See the above article for steps to install Jenkins
	Prerequisites for installing Jenkins
	 Note: These steps worked at the date of publication and may no longer be accurate. Please review the latest documentation on installing Java for your distribution of Linux. 
	Java needs to be installed and configured on the server on which you want to configure Jenkins. OpenJDK is preferred with Jenkins, but you can also use any other version of Java.
	# yum install java-11-openjdk-devel
	If multiple Java versions are installed on your server, you can specify the default Java version using this command:
	# update-alternatives --config java
	Install the wget tool in your operating system to fetch the Jenkins repository:
	# yum install wget
	Installing Jenkins
	To install Jenkins on to your operating system, follow the latest documentation provided by Jenkins. At the time of writing, you first need to configure yum by adding the Jenkins repository and then import the repository GPG key:
	 wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo#
	 rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
	You can check the presence of the repo using this command:
	# yum repolist
	The following links are for the LTS version for Jenkins. You can also use the latest build.
	When the repository is updated, you need to install Jenkins and start the service. Using the systemctl start command starts the Jenkins service and enabling the service will start it on bootup.
	To check if the Jenkins service is running, use the command:
	# systemctl status jenkins
	You also need to add Jenkins service to run with firewall and add its exception so that it is available to access from the outside world. Finally, we need to reload the firewall service for the changes to take effect.
	# firewall-cmd --add-port=8080/tcp --permanent# firewall-cmd --reload
	To check the firewall status and accessible ports, use the firewall-cmd command:
	# firewall-cmd --list-all
	Now, the Jenkins server will be running on port 8080 for our server.
	Configuring Jenkins
	You can configure the Jenkins service on port 8080 of your system, but Jenkins is temporarily locked with a password present in the  /var/lib/jenkins/secrets/initialAdminPassword file. You can access Jenkins by providing the password after reading the file.
	Image
	
	Remember to open the file with root user permissions as it is not accessible otherwise.
	Install the suggested plugins for Jenkins. They are compatible with most versions, but if you want to do something specific, you can also select and work with the plugins you wish.
	Image
	
	The plugins will take some time to install depending on the connectivity speed, so be patient.
	Create an admin user. Make sure you remember the username and password, as they are the credentials for accessing the Jenkins WebUI.
	Image
	
	Specify if you wish to change the port for your Jenkins. It is preferred to use Jenkins on 8080 port.
	Image
	
	Jenkins setup is complete and it can be accessed with the URL that is configured for it.
	Image
	
	
	From <https://www.redhat.com/sysadmin/install-jenkins-rhel8> 
	
	- My username for Jenkins is Njibrigthain100 and password is Pigeons@2022
	- Jenkins uses plugins
	- Jenkins is used for continuous integration, continuous delivery, continuous monitoring, continuous deployment, continuous security, continuous security and continuous development
	
	INSTALLING NEXUS
	- Create a user called nexus and sudo into that user
	- https://devopscube.com/how-to-install-latest-sonatype-nexus-3-on-linux/
	Sonatype Nexus is one of the best open-source artifact management tools. It is some tool that you cannot avoid in your CI/CD pipeline. It effectively manages deployable artifacts.
	Sonatype Nexus System Requirements
		Minimum 1 VCPU & 2 GB Memory
		Server firewall opened for port 22 & 8081
		OpenJDK 8
		All Nexus processes should run as a non-root nexus user.
	Note: For production setup, please consider minimum production hardware requirements based on the nexus usage and data storage. Check out the official system requirements document for detailed information
	Sonatype Nexus 3 on Linux ec2
	This article guides you to install and configure Sonatype Nexus 3 in a secure way on an ec2 Linux System.
	Note: This was tested on a Redhat machine and it will work on Centos or related Linux flavors as well.
	Step 1: Login to your Linux server and update the yum packages. Also install required utilities.
	sudo yum update -y
sudo yum install wget -y
	Step 2: Install OpenJDK 1.8
	sudo yum install java-1.8.0-openjdk.x86_64 -y
	Step 3: Create a directory named app and cd into the directory.
	sudo mkdir /app && cd /app
	Step 4: Download the latest nexus. You can get the latest download links fo for nexus from here.
	sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
	Untar the downloaded file.
	sudo tar -xvf nexus.tar.gz
	Rename the untared file to nexus.
	sudo mv nexus-3* nexus
	Step 5: As a good security practice, it is not advised to run nexus service with root privileges. So create a new user named nexus to run the nexus service.
	sudo adduser nexus
	Change the ownership of nexus files and nexus data directory to nexus user.
	sudo chmod -R 775 /app/nexus 
	sudo chmod -R 775 /app/sonatype-work 
	sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype-work
	Step 6: Open /app/nexus/bin/nexus.rc file
	sudo vi  /app/nexus/bin/nexus.rc
	Uncomment run_as_user parameter and set it as following.
	run_as_user="nexus"
	Step 7: If you want to change the default nexus data directory, open the nexus properties file and change the data directory -Dkaraf.data parameter to a preferred location as shown below. If you don’t specify anything, by default nexus data directory will be set to /app/sonatype-work/nexus3
	Tip: For production setup, it is is always better to mount the nexus data directory to a separate data disk attached to the server. So that backup and restore can be done easily.
	Create Nexus as a service
	Sudo ln -s /app/nexus/bin/nexus /etc/init.d/nexus 
	Switch to the nexus user and start the nexus service as follows 
	Sudo systemctl start nexus
	Sudo systemctl enable nexus 
	- Sonaqube runs on port 900 so after running all the commands you can do a telnet on the server ip n port 9000
	- So it will look like telnet xxx.xx.xx.xxx  9000 where xxx.xx.xx.xxx is the server IP
	- You can get the server IP by running hostname -I
	- The output should say connected
	
	INSTALLING NEXUS
	How to Install Nexus on RedHat Linux
	Nexus is binary repository manager, used for storing build artifacts. We will eventually integrate Nexus with Jenkins for uploading WAR/EAR/JAR files there.
	
	Here are the steps for installing Sonatype Nexus 3 in RHEL in EC2 on AWS. Please create a new Redhat EC2 instance with small type. Choose Redhat Enterprise 8.
	
	Pre-requisites:
	Make sure you open port 8081 in AWS security group
	
	Installation Steps:
	
	sudo yum install wget -y

	Download Open JDK
	sudo yum install java-1.8.0-openjdk.x86_64 -y
	Execute the below command to navigate to /opt directory by changing directory:
	cd /opt
	
	Download Nexus
	sudo wget http://download.sonatype.com/nexus/3/nexus-3.23.0-03-unix.tar.gz
	
	Extract Nexus
	sudo tar -xvf nexus-3.23.0-03-unix.tar.gz
	sudo mv nexus-3.23.0-03 nexus
	
	Create a user called Nexus
	sudo adduser nexus
	
	Change the ownership of nexus files and nexus data directory to nexus user.
	sudo chown -R nexus:nexus /opt/nexus
	sudo chown -R nexus:nexus /opt/sonatype-work
	
	Configure to run as Nexus user
	change as below screenshot by removing # and adding nexus
	 sudo vi /opt/nexus/bin/nexus.rc
	
	Modify memory settings in Nexus configuration file
	sudo vi /opt/nexus/bin/nexus.vmoptions
	
	Modify the above file as shown in red highlighted section:
	
	
	-Xms512m
	-Xmx512m
	-XX:MaxDirectMemorySize=512m
	after making changes, press wq! to come out of the file.
	
	Configure Nexus to run as a service
	
	sudo vi /etc/systemd/system/nexus.service
	Copy the below content highlighted in green color.
	
	[Unit]
	Description=nexus service
	After=network.target
	[Service]
	Type=forking
	LimitNOFILE=65536
	User=nexus
	Group=nexus
	ExecStart=/opt/nexus/bin/nexus start
	ExecStop=/opt/nexus/bin/nexus stop
	User=nexus
	Restart=on-abort
	[Install]
	WantedBy=multi-user.target
	
	Create a link to Nexus
	sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
	
	Execute the following command to add nexus service to boot.
	
	sudo chkconfig --add nexus
	sudo chkconfig --levels 345 nexus on
	
	Start Nexus
	sudo service nexus start
	
	Check whether Nexus service is running
	sudo service nexus status
	
	Check the logs to see if Nexus is running
	tail -f /opt/sonatype-work/nexus3/log/nexus.log
	
	You will see Nexus started..
	If you Nexus stopped, review the steps above.
	
	Now press Ctrl C to come out of this windows.
	
	Once Nexus is successfully installed, you can access it in the browser by URL - http://public_dns_name:8081
	
	Click on Sign in link
	user name is admin and password can be found by executing below command:
	
	sudo cat /opt/sonatype-work/nexus3/admin.password
	
	
	
	Copy the password and click sign in.
	Now setup admin password as admin123
	
	
	you should see the home page of Nexus:
	
	
	- 
	
CONFIGURING JENKINS ON THE GUI
          Jenkins Integration: mvn package
	- https://github.com/BK-organization/maven-web-application
	- To clone the project we can run git clone plus url 
	- For repos in a private repo you need username and password (credentials) but you don’t need one with public repos
	- Add your username and password after pasting the url for the Github repo
	- The build system we will be using for our project is maven
	- To create a project to new item and input a name for the project and select freestyle project 
	- Now you input the description for the project and then the name of the SCM which in our case is GitHub
	- 
	
	- The above picture shows you the output of the first build
	- The above is just like cloning your code from git hub
	- To edit a build select the project and select configure and then go to build 
	- To add plugins to Jenkins go to manage Jenkins-> global tool configuration and then go add the tool you want
	- In our case we added maven 3.8.7
	- Now go back to your project under configure->build and select the version of maven you just added
	
	Jenkins SonarQube integration: mvn sonar:sonar
	- Here the SonarQube server must be running

    INSTALLING SONAQUBE ON AMAZON LINUX 2
	- Start by installing java first 
	Steps to set JAVA enviroment variable on Amazon Linux in 4 simple steps. (Updated 14th Jan 2020)
	Step 1: Check & install correct JAVA version (Optional)
	Check if JAVA exists on your device by running : java --version
	The latest version of JAVA OpenJDK is 1.8, by default Amazon Linux AMI may or may not a JAVA installation so you would directly want to install/upgrade it use below command :
	You can list all the available OpenJDK versions using : sudo yum list | grep openjdk
	You can select the desired version from the output list and install it
	sudo yum install java-1.8.0-openjdk.x86_64
	If you already have JAVA installed you can change/check the JAVA version using below command.
	$ sudo update-alternatives --config java
	Note: If above command doesn’t give any JAVA version option then try once again after running sudo yum update -y command.
	Select an option as shown in the image below:
	
	Note: It is advisable to remove the previous version so that it doesn’t switch back.
	Step 2: Find out where JAVA is!
	For Linux systems, you can recursively run the commandfile followed by which command to find the JAVA installation location as shown in the image below.
	$ file $(which java)
	 
	 The above output shows that JAVA is pointing to a /etc/alternatives/java file but that is not the actual location of JAVA hence you will need to dig in more to fetch its actual path.
	Step 3 :  Follow the lead!
	In the previous step, we located /etc/alternatives/java file this file will get us to the actual location where JAVA config files are.
	Run the file command on that location /etc/alternatives/java.
	$ file /etc/alternatives/java
	There you go… You’ve now located JAVA config file location which we will use in below steps to set JAVA environment variable
	You can re-affirm the location running  file command on the symbolic path:
	$ file /usr/lib/jvm/java-8-openjdk.x86_64/bin/java
/usr/lib/jvm/java-8-openjdk.x86_64/bin/java: ELF 64-bit LSB executable...
	This means that the JAVA is installed perfectly, Now go ahead and copy the path of above output
	/usr/lib/jvm/jdk-1.8.0-openjdk.x86_64/bin
	Step 4:  Set JAVA environment variable 
	To set the JAVA_HOME environment variables on Linux/Unix go to .baschrc file.
	Note: .bashrc file is different for each user in Linux, hence you will need to update the same file for every user you want to set environment variable for.
	Copy paste below two lines in the .bashrc file found in home the directory of ec2-user and root user:
	 export JAVA_HOME="/usr/lib/jvm/jdk-1.8.0-openjdk.x86_64"
	 PATH=$JAVA_HOME/bin:$PATH
	Save the file and run the following command:
	source .bashrc
	Note: Running the source command is mandatory otherwise you will not see the environment variable set.
	Alternatively, you can also set $PATH variable through the command line:
	Run the following command to add $JAVA_HOME variable to $PATH:
	$ export PATH=$PATH:$JAVA_HOME/bin
   Installing Sonaqube:
	Step 1 : Download and Install SonarQube
	Ensure you have java environment variable set on your system, usually amazon linux has this already preconfigured with it but incase if your using any other distro then I would recommend to do this, you can find reference for the same here.
	First add repo using below command
	sudo wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
	then install SonarQube by running :
	sudo yum install sonar
	you can start/stop sonar using : sudo service start/stop sonar
	Once this is done, you should be able to access SonarQube dashboard via browser with http://<ipaddress>:9000
	Step 2 : Install and start MySQL database (Optional)
	sudo yum install mysqld
	sudo service mysqld start
	To configure root password for first time use below command : 
	sudo mysql_secure_installation
	MySQL installation is optional as it not required while integrating it with Jenkins and Git which is what we are trying to do in this series.
	- Username is admin and password is admin 


	- INSTALLING SONARQUBE ON RED HAT 9
	Snap is available for Red Hat Enterprise Linux (RHEL) 8 and RHEL 7, from the 7.6 release onward.
	The packages for RHEL 8 and RHEL 7 are in each distribution’s respective Extra Packages for Enterprise Linux (EPEL) repository. The instructions for adding this repository diverge slightly between RHEL 8 and RHEL 7, which is why they’re listed separately below.
	The EPEL repository can be added to RHEL 8 with the following command:
	sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf upgrade
	
	The EPEL repository can be added to RHEL 7 with the following command:
	sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	
	Adding the optional and extras repositories is also recommended:
	sudo subscription-manager repos --enable "rhel-*-optional-rpms" --enable "rhel-*-extras-rpms"
sudo yum update
	Snap can now be installed as follows:
	sudo yum install snapd
	Once installed, the systemd unit that manages the main snap communication socket needs to be enabled:
	sudo systemctl enable --now snapd.socket
	To enable classic snap support, enter the following to create a symbolic link between /var/lib/snapd/snap and /snap:
	sudo ln -s /var/lib/snapd/snap /snap
	Either log out and back in again or restart your system to ensure snap’s paths are updated correctly.
	Install Sonar
	To install Sonar, simply use the following command:
	sudo snap install sonar
	Start sonar 
	Sudo systemctl start sonar
	Verify status
	Sudo systemctl status sonar
	
	ccdwscdw


	
	
	
	
	
	
	






























