INSTALLING SONAQUBE ON AMAZON LINUX 2 AND RED HAT
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
# /usr/bin/java: symbolic link to `/etc/alternatives/java'
	The above output shows that JAVA is pointing to a /etc/alternatives/java file but that is not the actual location of JAVA hence you will need to dig in more to fetch its actual path.
	Step 3 :  Follow the lead!
	In the previous step, we located /etc/alternatives/java file this file will get us to the actual location where JAVA config files are.
	Run the file command on that location /etc/alternatives/java.
	$ file /etc/alternatives/java
# /etc/alternatives/java: symbolic link to `/usr/lib/jvm/java-8-openjdk.x86_64/bin/java'
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
	- 
