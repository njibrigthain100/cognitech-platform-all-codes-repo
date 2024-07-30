#!/bin/bash
username1=brigthain
username2=ansible
username3=nexus
echo "Please enter your username"
read username
if [ -f /etc/system-release ]
then 
    if [ $username == $username1 ] || [ $username == $username2 ] || [ $username == $username3 ]
    then 
    echo "A new user will be created in the system"
    else
    echo "Sorry you have entered the wrong username"
    fi
    # The user is created here based on the user who has logged in
    if [ $username == $username1 ] || [ $username == $username2 ] || [ $username == $username3 ]
    then
    sudo adduser "$username"
    else
    echo "The wrong username has been entered please try again"
    fi
    echo "Please enter a unique password for your user"
    read -s password
    echo "password" | sudo passwd "$username" --stdin
    echo "$username  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$username
elif cat /etc/issue|grep -i 'Ubuntu' 
then
    sudo adduser "$username" 
    read password 
    sudo adduser "$username" sudo 
else 
    echo "Wrong operating system selected"
fi
#This part of the script will update all your packages
if [ -f /etc/system-release ]
then
    if cat /etc/system-release|grep -i 'Amazon Linux release 2' 
    then
         sudo yum update -y
         sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
         sudo yum install -y ansible
         sudo yum -y install unzip
         #This part of the script will install awscl2 for this server
         curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        echo "awscli-2 has succesfully been installed in your server"
        #This part of the script will install wget 
        sudo yum install wget -y 
        echo "wget has succesfully been installed in your server"
        #This command will install tree
        sudo yum install tree -y
        #This part of the script will install docker
        sudo yum install docker -y 
        sudo systemctl enable docker.service
        sudo systemctl start docker.service
        echo "Docker has succesfully been installed in your server"
        # Please store all temporary files that you will not need in this directory
        mkdir -p /tmp/storage/
        chown ec2-user:ec2-user /tmp/storage
        echo "Your temporary directory has been created. This directory will be deleted during the next script run"
        # This command will delete all files in the /tmp/storage directory
        rm -rf /tmp/storage/*
    elif cat /etc/system-release|grep -i 'Amazon Linux release 2022' 
    then
        sudo yum update -y
         sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
         sudo yum install -y ansible
         sudo yum -y install unzip
         #This part of the script will install awscl2 for this server
         curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        echo "awscli-2 has succesfully been installed in your server"
        #This part of the script will install wget 
        sudo yum install wget -y 
        echo "wget has succesfully been installed in your server"
        #This command will install tree
        sudo yum install tree -y
        #This part of the script will install docker
        sudo yum install docker -y 
        sudo systemctl enable docker.service
        sudo systemctl start docker.service
        echo "Docker has succesfully been installed in your server"
        # Please store all temporary files that you will not need in this directory
        mkdir -p /tmp/storage/
        chown ec2-user:ec2-user /tmp/storage
        echo "Your temporary directory has been created. This directory will be deleted during the next script run"
        # This command will delete all files in the /tmp/storage directory
        rm -rf /tmp/storage/*
    elif cat /etc/system-release|grep -i 'Red Hat Enterprise Linux' 
    then
         #This part of the script will install awscl2 for this server
         curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install

        echo "awscli-2 has succesfully been installed in your server"
        #This part of the script will install wget 
        sudo yum install wget -y 
        echo "wget has succesfully been installed in your server"
       #This command will install tree
        sudo yum install tree -y
        # #This part of the script will install docker
        # sudo yum install -y yum-utils
        # sudo yum-config-manager \
        #     --add-repo \
        #     https://download.docker.com/linux/rhel/docker-ce.repo
        # sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
        # sudo systemctl start docker
        # sudo docker run hello-world
        # echo "Docker has succesfully been installed in your server"
        #This command will install SSM
        sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
        sudo systemctl start amazon-ssm-agent
        sudo systemctl enable amazon-ssm-agent
        echo "SSM has succesfully been installed in your server"
        #These commands will install Jenkins in your server
        sudo yum install unzip wget tree git -y
        sudo yum install java-11-openjdk-devel
        sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
        sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
        sudo yum install jenkins -y
        sudo systemctl start jenkins
        sudo systemctl enable jenkins
        echo "Jenkins has been succesfully installed on your server"
        #This commands will install Nexus to your server
        sudo yum update -y 
        sudo mkdir /app 
        cd /app 
        sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz 
        sudo tar -xvf nexus.tar.gz
        sudo mv nexus-3* nexus
        sudo chown -R nexus:nexus /app/nexus
        sudo chown -R nexus:nexus /app/sonatype-work
        sudo chmod -R 775 /app/nexus 
        sudo chmod -R 775 /app/sonatype-work 
        # Please store all temporary files that you will not need in this direct
        mkdir -p /tmp/storage/
        chown ec2-user:ec2-user /tmp/storage
        echo "Your temporary directory has been created" 
        # This command will delete all files in the /tmp/storage directory
        rm -rf /tmp/storage/*
    else
        echo "There was a problem with the operating system you selected"
    fi
elif cat /etc/issue|grep -i 'Ubuntu' 
then
        sudo adduser 
        sudo apt update
        sudo apt-add-repository ppa:ansible/ansible
        sudo apt install ansible
         #This part of the script will install awscl2 for this server
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        echo "awscli-2 has succesfully been installed in your server"
        #This part of the script will install wget 
        sudo apt install wget
        echo "wget has succesfully been installed in your server"
       #This command will install tree
         sudo apt install tree
        #This part of the script will install docker
        sudo apt-get remove docker docker-engine docker.io
        sudo apt install docker.io
        sudo snap install docker
        echo "Docker has succesfully been installed in your server"
        # Please store all temporary files that you will not need in this direct
        mkdir -p /tmp/storage/
        chown ec2-user:ec2-user /tmp/storage
        echo "Your temporary directory has been created" 
        # This command will delete all files in the /tmp/storage directory
        rm -rf /tmp/storage/*
else     
    echo "Files does not exist or you have selected the wrong operating system"
fi
THRESHOLD=85
df -h | grep -vE 'Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output
  usep=$(echo $output | awk '{ print $1 }' | cut -d'%' -f1 )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge $THRESHOLD ]; then
     echo "Running out of memory space \"$partition ($usep%)\" on $(hostname) as on date $(date)" |
     mail -s "Alert: Almost out disk space $usep% kbrigthain@gmail.com"
  fi
done
