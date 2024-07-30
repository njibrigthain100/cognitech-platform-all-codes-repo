#!/bin/bash
username=nexus
password=nexus
sudo adduser $username
echo "password" | sudo passwd "$username" --stdin
echo "$username  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$username
