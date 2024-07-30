How to Install Nexus on RedHat Linux
Nexus is binary repository manager, used for storing build artifacts. We will eventually integrate Nexus with Jenkins for uploading WAR/EAR/JAR files there.
Username: admin
Password: Pigeons@2022
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



