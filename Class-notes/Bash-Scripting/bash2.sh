#!/usr/bin/bash
if [ -f /etc/os-release ]
then
    echo "file exist"
    ret=$(egrep -i 'Amazon Linux release 2' /etc/os-release)
    if [ $? -ne 0 ]
    then
         sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
         sudo yum install -y ansible
         sudo yum -y install unzip
    else
        echo "Amazon Linux release 2 not found"
    fi
else
    echo "File found but not the correct operating system"
fi