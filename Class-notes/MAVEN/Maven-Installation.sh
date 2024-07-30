	- Maven can be installed on any platform
	- Go to https://maven.apache.org/download.cgi
	- Maven can be installed in
		○  Linux: RedHat, Ubuntu, CentOS
		○ Window: server 2012, 2016, 2019, windows XP7, 8, 19, 11
		○ MacOS:
		○ Solaris
	- Java is a pre requisite for maven to run. Maven will not run if java is not available
	- When you install java the JDK is also installed. You need a JDK of 1.8+ to function
	- https://github.com/LandmakTechnology/package-management/tree/master/Maven-installation
	Apache Maven Installation And Setup In AWS EC2 Redhat Instance.
	Prerequisite
	+ AWS Acccount.
	+ Create Security Group and open Required ports.
	   + 22 ..etc
	+ Create Redhat EC2 T2.medium Instance with 4GB of RAM.
	+ Attach Security Group to EC2 Instance.
	+ Install java openJDK 1.8+
	
	### Install Java JDK 1.8+  and other softares (GIT, wget and tree)
	# install Java JDK 1.8+ as a pre-requisit for maven to run.
	sudo hostnamectl set-hostname maven
	sudo su - ec2-user
	cd /opt
	sudo yum install wget nano tree unzip git-all -y
	sudo yum install java-11-openjdk-devel java-1.8.0-openjdk-devel -y
	java -version
	git --version
	```
	## 2. Download, extract and Install Maven
	To install maven we can simply run sudo yum install maven but this does not give us the version we want. 
	#Step1) Download the Maven Software from the internet using the wget command
	sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.tar.gz
	Or sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.zip
	Both the above links were gotten from  https://maven.apache.org/download.cgi where it list all the version for maven that you can download
	
	Step2) unzip the tar or zip files after downloading
	sudo tar xzf apache-maven-3.8.5-bin.tar.gz for tar file 
	OR
	sudo unzip apache-maven-3.8.6-bin.zip for zip file
	
	Step3)Remove the zip or tar file
	sudo rm -rf apache-maven-3.8.6-bin.zip
	sudo rm -rf apache-maven-3.8.6-bin.tar.gz
	
	Step4)Rename the extracted file to maven
	sudo mv apache-maven-3.8.6/ maven
	
	Step5) Set Environmental Variable  - For Specific User eg ec2-user
	vi ~/.bash_profile  # and add the lines below
	export M2_HOME=/opt/maven
	export PATH=$PATH:$M2_HOME/bin
	```
	Step6) Refresh the profile file and Verify if maven is running
	source ~/.bash_profile
	mvn -version

