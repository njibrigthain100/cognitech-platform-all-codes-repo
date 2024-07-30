	• Packer is an open source tool that allows us to create a custom images across a multitude of platforms
	• Mutable means to change while immutable is unchanged
	• In a mutable infrastructure when we deploy the server we have to configure certain things such as patching the server, updating the repos etc. This means that this infrastructure changes. This happens in the traditional model. Down the road if you need to make any changes you need to mutate it once again. This works if you have one server. However, the real problem happens when you have multiple servers. Config drift can happen here with some servers not getting the configurations that they need while others do.
	• There are automation tools built for this like ansible which helps with preventing configuration drift.
	• So to recap in mutable infrastructure we go from development to deployment and then configuration
	 
IMMUTABLE INFRASTRUCTURE
	• In immutable infrastructure we configure the server before we deploy it.This is where packer comes into play.
	• With packer we can build images that already have all the necessary requirements for the server you are trying to deploy.
	• Packer can help create a custom AMI
	• With an immutable infrastructure (like packer) we can take the application code and configuration and bake them into the image.
	• So all we do is deploy the image into the server and the server is production ready
	• That’s why its called immutable so we cant change it. However, if we need to make some changes down the road we simply kill that server and deploy a new server.  We can avoid down time in this case by spinning up a load balancer which send traffic to the other servers.
 
             SETTING UP PACKER ON WINDOWS, LINUX AND MACOS
	• To setup packer you go to packer.io and download from there
	• Installed in mac using homebrew
	• To install homebrew go to google and type homebrew. Proceed to the web browser and copy the link in the front page and paste on the CLI and the process should start downloading all the necessary binaries you need.
	• After homebrew is installed simply run brew install packer. If the installation for packer don’t work using the above method follow this link to help with installation https://stackoverflow.com/questions/64963370/error-cannot-install-in-homebrew-on-arm-processor-in-intel-default-prefix-usr
 
         BUILDING YOUR FIRST AMI
	• First you have to create a directory to store all our source code mine is packer and im using vs code as my text editor
	• Packer uses a json format
	• First.json will contain all the configurations that you need for packer
	• A packer config has 3 building blocks: builders, Provisioners and post processors
     
      BUILDERS
	• They are responsible for creating a machine and generating images from them across various platforms. Packer supports a ton of platforms
	• These are the main components for packers
	• Go to the packer home page and select builders on the left pane which shows all the documentations that we will need. Go to https://www.packer.io/plugins/builders/amazon/ebs for all the necessary info on AMI creation
	• Packer allows you to pass multiple builders so go to your text editor and in in-between the curly braces type the word builders in parenthesis. See example below
	• You need to provide keys for your aws environment. To find access information go to your aws account and select your username and go to security credentials. Here you should be able to see your access key and secret access key.
	• Access key for me is: AKIAXB5IN5PEKWT5M5OU
	• Secret access key is: SY4m3B/C/8Y7xMS0WwM9xUJT7juWPrMChmo/hhzb
	• Region is us-east 1
	• We are going to hard these now but will move them someplace else later
	• Under AMI configuration one requirement is the ami_name
	• There's other properties that you can put in but the name is the only one that’s required all the others are optional
	• We have to give packer an ami that we want to tweak to create ours
	• Go to your console to get one that you want to tweak
	• We need an instance type because packer creates an instance to be able to create the AMI you want. However, this instance is deleted by packer after the AMI is created. So it’s a temporary instance
	• Next you provide the ssh_username for packer to log in to that instance and create the ami. Default user name is usually ec2-user but ubuntu is ubuntu for ubuntu VMs
	 
{
    "builders": [
        {
            "type": "amazon-ebs",
            "access_key": "AKIAXB5IN5PEKWT5M5OU",
            "secret_key": "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",
            "region": "us-east-1",
            "ami_name": "bk-ami",
            "source_ami": "ami-0022f774911c1d690",
            "instance_type" "t2.micro",
            "ssh_username" "ec2-user"
        }
    ]
}
	 
	• Above is the example for base configuration to create an AMI
	• Now go to your terminal in either VS code or the CLI on your local computer and navigate to the folder you are working on. Mine is first.json.
	• Now run the command packer build plus project nameto build the ami and let it run
	• In the output during the launching you see that it launches an instance and then later deletes it
	• Now if you go to the console under AMI's you will see your newly created AMI and you can use that AMI to launch an EC2-instance
	• To terminate an AMI go to the AMI tap, select the AMI and go under actions and deregister the AMI
 
PROVISIONERS
	• This is the second aspect of a packer configuration and where the customizability comes into play
	• This is where we can install and configure our machine image
	• They use built-in and third party software to install and configure the machine image after booting. They prepare the system for use.
	• There are several different types of provisioners and it supports automation tools like ansible, chef, puppet etc
	• We are using shell provisioners here
	• We are using an ubuntu ami here
	• Here we will use a provisioner to install nginx into our AMI
	• To create a provisioner we run like we are running the builder in json format
	• See below for example
	• The provisioner has the type and the inline property for shell
	• To avoid packer from instantly SSHing into the box upon reboot and start making config changes to the server without the rest of the operating system being up. Its best to set a sleep x( in which x is any number of your choosing) so that packer waits for some time for the system to properly be up before it starts making any changes
 
{
    "builders": [
        {
            "type": "amazon-ebs",
            "access_key": "AKIAXB5IN5PEKWT5M5OU",
            "secret_key": "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",
            "region": "us-east-1",
            "ami_name": "Bk-ubuntu-ami-project-2",
            "source_ami": "ami-09d56f8956ab235b3",
            "instance_type": "t2.micro",
            "ssh_username": "ubuntu"
        }
    ],
    "provisioners": [
        {
            "type": "shell",
            "inline":[
                "sleep 30","sudo apt update","sudo apt install nginx -y"]
        }
    ]
}
	• Make sure that you bake as much as possible in the image to avoid doing any manual configurations
	• Make sure to setup firewalls, web applications etc
	• Ufw stands for uncomplicated firewall
	• Instead of having to type multiple commands like the one in project 2 in the inline command you can use a script which makes everything more neat. So in this case you create a new file where you will input the script. In our case its called setup.sh
	• In our example the setup.sh script is in the same directory as the json file hence we can just pass in the script name. however if the script was stored anywhere else in our OS we will have to pass in the full path
	• After running the command and provisioning the AMI, create an instance from that AMI and check nginx status by typing systemctl status nginx. It should say nginx is active
	• You can go to the nginx browser by editing the security group for that instance and adding port 80 and 443
	• Now copy the public IP address and paste it in a web browser and you should see the nginx welcome page
	• To not see the default web page but see our own custom web page go to the etc/nginx/sites-availabledirectory
	• Now cat into the default file and there you will see where the html file is stored which is usually root/var/www/html
	• Now go to that directory
	• Now to have our own website there instead of the welcome nginx page we will use a provisioner that will allow us to copy an html file from our local machine unto the EC2 instance
	• We will use the file provisionerin this case
	• Here we will be working in project 4
	• We can have an array of provisioners so here we will be adding the file provisioner to the project
	• Now create another file for the index.html file creation
	• To create a boiler plate for an html file in VS code simply type html and select the html:5 which gives you a template for an html file
	• In this case the first try failed cause the ubuntu user didn’t have permissions in the var/www/index directory. However, all users have full access in the /tmp directory so we can either use that or we can change ownership in the var/www/html directory to ubuntu
	• The file provisioner doesn’t give us sudo privileges so after creating the index file in the /tmp directory we can use the shell provisioner to cp the file from the tmp directory to the var/www/html directory
 
POST-PROCESSORS
	• Post processors run after the image is built by the builder and provisioned by the provisioner(s). They are optional, and they can be used to upload artifacts, re-package, or more.
	• We can create a vagrant boxes with post processors
	• We used manifestand vagrantpost processors
	• The manifest post-processor writes a JSON file with a list of all of the artifacts packer produces during a run. If your Packer template includes multiple builds, this helps you keep track of which output artifacts (files, AMI IDs, docker containers, etc.) correspond to each build.
	• The manifest post-processor is invoked each time a build completes and updates data in the manifest file. Builds are identified by name and type, and include their build time, artifact ID, and file list.
	• With manifest every time a build is run the new build artifacts will be added to the manifest file rather than replacing it.
	• The Packer Vagrant post-processor takes a build and converts the artifact into a valid Vagrant box, if it can. This lets you use Packer to automatically create arbitrarily complex Vagrant boxes, and is in fact how the official boxes distributed by Vagrant are created.
	• Vagrant is an open-source tool that allows you to create, configure, and manage boxes of virtual machines through an easy to use command interface. Essentially, it is a layer of software installed between a virtualization tool (such as VirtualBox, Docker, Hyper-V) and a VM
 

Kargong, Brigthain	12:21 PM (2 hours ago)	
		
		
to me		

What is Hashicorp Packer
	• It builds machine images
	• An AMI is a resource that stores all the configurations, permissions and metadata needed to create a virtual machine
	• It can be called a golden image
	• Packer isn't limited to Linux, you can provision a machine image using windows or other OS as well
	• The machine images will serve as roadmaps for building other virtual images
 
Why use Packer
	• Create images via a template
	• You can re-run the template without making any changes
	• Automate everything. It is usually tied with CICD pipelines
	• Create identical images. Cross cloud, cross environment, cross platform a single packer template can create machine images for multiple use cases
	• Provisions code we can use and re-use
 
Packer breakdown
	1. Builder:
	• Tells packer what platform, region and source image
	• Contains AMI name too
	• Only mandatory field
	2. Provisioner
	• This defines how to configure the image, most likely by using your existing configuration management platform. No need to rewrite, just reuse
	• Let's us leverage what we already have
	3. Post-processors
	• Related to the builder, runs after the image is built. Generally generates or supplies artifacts
	• What it does depends on your platform
	4. Communicator
	• How packer works on the machine image during creation. Y default this is SSH and does not need to be defined
	• This is how packer connects to the instance and it always assumes to be ssh
	• If you are using windows you have to provide the winRM communicator.
	• You might not notice the communicator
 
	• A build in packer is a combination of the builder, the provisioner and the post processors that you provide. A template can have multiple builds
	• An artifact is the end result of a build; generally this is the machine image itself and any generated log of metadata files
	• Command is what we need to run to manage packer.  Most often this is the packer build command
	 
JSON
	• How to structure your data in JSON
	• It is compromised of the object aka the name/value pair. Comprised of the opening and closing curly brackets. The names are in name/value pairs and end in a colon. When you have multiple objects they always end in a comma except for the last object {}
	• Array aka ordered  list, vector, list sequence
	• The array starts with a left bracket and ends with a right bracket []
	• Separate multiple pairs with a comma
	• Whitespace doesn’t really matter is JSON but 2 or 4 spaces are commonly used
Hands-on in json
	• To move all the lines from the first and last curly bracket, select all the lines from the second line all the way to the second to last line and do a shift plus HTML angle brackets (same as the > or the period button on the keyboard)
	• To highlight everything in the vi editor select shift + v and then select until the second to the last line then shift + > to shift everything to the right
	• Highlight all the objects in the builders until the second to the last curly bracket
	• There should always be some space between different objects
	• To validate if the template is correct always run packer validate plus name of template
	{
	  2         "variables": {
	  3             "aws_access_key": "AKIATW3SA5KON4SJLSQD",
	  4             "aws_secret_key": "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",
	  5             "aws_subnet_id": "subnet-0b9135191840a57d3"
	  6         },
	  7         "builders": [
	  8         {
	  9             "type": "amazon-ebs",
	10             "access_key": "{{user `aws_access_key`}}",
	11             "secret_key": "{{user `aws_secret_key`}}",
	12             "region": "us-east-1",
	13             "subnet_id": "{{user `aws_subnet_id`}}",
	14             "source_ami_filter": {
	15                 "filters": {
	16                     "virtualization-type": "hvm",
	17                     "name": "ubuntu/images/*ubuntu-focal-20.04-amd64-server-    *",
	18                     "root-device-type": "ebs"
	19             },
	20                 "owners": ["099720109477"],
	21                 "most_recent": true
	22                 },
	"ami-test.json" 39L, 1288C                                    1
	 
HCL2
	• This is Hashicorp configuration language
	• This is version 2 of the configuration language
	• It is human readable than json. So human first and it is also json compatible
	• You have the ability to add comments as well
	• It is also comprised of objects and arrays. Here it looks like this name ="value" and arrays are basically the same opening and closing with straight brackets as such [ "item", "item"]
	• In json you start with a curly brace and end with a curly brace. No more commas and colon switches to equal sign
	• HCL includes attributes as well. Example is the ami-name which is a single configuration unit, generally a name/value pair
	• Attributes can be contained in a block. A block is a collection of attributes with an annotated block type (filters)
	• A body is a collection of associated blocks. This can be the entire code as it can be used to create the AMI
	• Tabs or spaces still doesn’t matter with HCL
 
Packer Installation:
Windows:
	• 2 options: Either through packer.io which provides you with a packer binary. You can do it through chocolately.com. We can install chocolatey through windows powershell by running as an administrator.
	• First we have to make sure to set execution policy to bypass to ensure that all the commands we run are not restricted. This is done by running Set-ExecutionPolicy bypass -scope Process
	• To check for execution policy you can run Get-ExecutionPolicy
	• Now go to chocolatey.com and copy the link to install it and run the command on the powershell.
	• After chocolatey is install, install packer by running choco install packer
	• You can check version by running packer --version
Packer Plugins:
	• 3 different flavors. Builders, provisioners or post-processors
	• Any plugin must fit the layout of packer itself
	• We can either download the binary and move it to the appropriate location or we have to clone a repository and build the plugin ourself with go
	• To install go we run sudo apt install golang-go
 
Builders
	• The builder is what does the work to build our image
	• There are over 30 builders available to us to build an image
	• We will look at the amazon ebs builder
	• To call in values in packer and json you format them in the following form ex "access_key": "{{user 'aws_access_key'}}"
	• To create an ami and append the time when it was created we can do so by running the ami name as name-{{timestamp}}. This will give us the time when the ami was created plus the name of the ami.
	• The source ami filter is usually gotten from aws itself. It is just an ami already present in the console that we will use to customize to what we want.
	• In the setup ensure to input the virtualization type, the name of the ami. The name usually follows a convention as shown on the template. The root device type will be ebs and the owner will be found in the console. This is the number provided by the makers of that particular ami. The most recent set to true is to ensure that only the most recent ami are built.
 
Communicators
	• This is how packer works on the machine during creation. By default, this is SSH and does not need to be defined.
	• If we were using another communicator other SSH we would type it as "communicator": "winrm" in case of windows. However, since SSH its usually the default we will just tell packer how to ssh into the server
	• So in this case it will be ssh_username. In our case its ubuntu but its usually ec2-user
	• They help packer communicate temporarily to the instance
 
Example of valid template
{
        "variables": {
                "aws_access_key": "AKIAXB5IN5PEKWT5M5OU",
                "aws_secret_key": "SY4m3B/C/8Y7xMS0WwM9xUJT7juWPrMChmo/hhzb"
        },
        "builders":[
           {
                   "type": "amazon-ebs",
                   "access_key": "{{user `aws_access_key`}}",
                   "secret_key": "{{user `aws_secret_key`}}",
                   "region": "us-east-1",
                   "instance_type": "t2.micro",
                   "ami_name": "packer-base-ami-{{timestamp}}",
                   "source_ami_filter": {
                      "filters": {
                          "virtualization-type": "hvm",
                          "name": "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*",
                          "root-device-type": "ebs"
                      },
                      "owners": ["099720109477"],
                      "most_recent": true
                },
                "ssh_username": "ubuntu"
 
                   }
   ]
}
	• You can run packer fix to help fix your template and pipe the new template to a new file. So it will be packer fix packer.json > packer2.json
	• The packer fix automatically fixes the entire template. See below for new template
	{
	  "builders": [
	    {
	      "access_key": "{{user `aws_access_key`}}",
	      "ami_name": "packer-base-ami-{{timestamp}}",
	      "instance_type": "t2.micro",
	      "region": "us-east-1",
	      "secret_key": "{{user `aws_secret_key`}}",
	      "source_ami_filter": {
	        "filters": {
	          "name": "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*",  
	          "root-device-type": "ebs",
	          "virtualization-type": "hvm"
	        },
	        "most_recent": true,
	        "owners": [
	          "099720109477"
	        ]
	      },
	      "ssh_username": "ubuntu",
	      "type": "amazon-ebs"
	    }
	  ],
	  "variables": {
	    "aws_access_key": "AKIAXB5IN5PEKWT5M5OU",
	    "aws_secret_key": "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"       
	  }
	}
 
Provisioners:
Shell:
	• Provisions the machine using the image's default shell
	• It supports whatever the default shell is on the Linux machine you are using. It will either be bash or zsh
	• In windows you will use the windows shell provisioner
	• The inline command requires sudo so as to append any command that requires root privileges during the process
	• The shell provisioners provides a wide variety of parameters
	• You can add the inline function in which you add the command or the script name if you have one already written
 
Files:
	• Here you upload files and directories to the machine
	• We are going to be working with multiple scripts so we created a new directory and moved the shell.sh script into the new directory
	• Curl means client URL is a command tool that enables data transfer over various network protocols. It communicates with a web or application server by specifying a relevant URL and the data that need to be sent or received
	• With are going to set up a prometheus file for this example. A prometheus exporter is a piece of software that can fetch statistics from another, non-prometheus system. It can turn those statistics into prometheus metrics, using a client library.
	• We need the node-exporter.tar.gz file and the node_exporter.service file
	Node Exporter is a Prometheus exporter for server level and OS level metrics with configurable metric collectors. It helps us in measuring various server resources such as RAM, disk space, and CPU utilization
	A Tar file is an archive that consists of multiple files put into one, while GZ is a compressed file format. Thus, combining TAR and GZ into a TAR. GZ provides you with a compressed archive.
	• We need to create a files directory
	• To create the files directory we run mkdir files
	• And run the command curl -J -L to preserve the files structure
	• The trailing slash after a directory dictates how it is uploaded. Directories with a slash upload only the contents of the directory (/tmp/somefile1.tar)
	• Directories without a slash create a new directory (/tmp/directory/*)
 
Ansible:
	• We provision using a remote ansible server by running ansible playbook over SSH
	• Or we can install ansible on the remote and use it to configure the localhost
	• We will be using option 2 in this case
	• Here we are trying to get to the same results we did earlier except that we want to do so using ansible
	• Sometimes you need to help out the provisioners by adding some inline code for them to function
	• We need to run an inline command to install ansible provisioner cause the ansible local provisioner does not install ansible
	• Other provisioners are chef, puppet etc
	• To install ansible on the local you run sudo apt install ansible -y
	 
	{
	        "variables": {
	                "aws_access_key": "AKIAXB5IN5PEKWT5M5OU",
	                "aws_secret_key": "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"
	        },
	        "builders":[
	           {
	                   "type": "amazon-ebs",
	                   "access_key": "{{user `aws_access_key`}}",
	                   "secret_key": "{{user `aws_secret_key`}}",
	                   "region": "us-east-1",
	                   "instance_type": "t2.micro",
	                   "ami_name": "packer-base-ami-{{timestamp}}",
	                   "source_ami_filter": {
	                      "filters": {
	                          "virtualization-type": "hvm",
	                          "name": "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*",
	                          "root-device-type": "ebs"
	                      },
	                      "owners": ["099720109477"],
	                      "most_recent": true
	                },
	                "ssh_username": "ubuntu"
	 
	                   }
	   ],
	   "provisioners":[
	        {
	            "type": "shell",
	            "inline":  [
	                    "sudo apt update -y && sudo apt upgrade -y",
	                    "sudo apt install ansible -y"
	            ]
	        },
	        {
	            "type": "file",
	            "source": "app",
	            "destination": "/home/ubuntu/"
	        },
	        {
	            "type": "ansible-local",
	            "playbook_file": "playbook.yml"
	        }
Post-Processors:
	• Related to the builder, run after the image is built. Generally or supplies artifacts
	• For example provisioning a vagrant box
	• The output : vagrant.tar.gz tells packer to take our image and compress it into a tar.gz file
	• Post-processors let us do the following: repackage the image (amazon import, docker import, vagrant), upload or alter artifacts (artifice, compress, manifest, docker build, docker tag), and more such as checksum (evaluate checksums for us) and shell (This will run commands for us after the build is complete)
 
Parallel builds:
	• One benefit of packer it lets us build cross platform
	• This helps us run 2 builders in parallel
 
AMI-BUILD
	• The kickstart file(KS) is a simple text file containing a list of items each identified by a keyword. It is in the root users home directory
	What is the BIOS in Linux?
	A BIOS (basic input output system) is a small program that controls a personal computer's hardware from the time the computer is started until the main operating system (e.g., Linux, Mac OS X or MS-DOS) takes over
	What is GRUB boot Linux?
	Grub is the boot menu. If you have more than one operating system installed, it allows you to select which one to boot. Grub is also useful for troubleshooting. You can use it to modify the boot arguments or to boot from an older kernel.
	• When you boot your server BIOS starts first by running a small program that controls the personal hardware of the system until the main OS takes over. GRUB then takes over BIOS at boot time, loads itself, load the Linux kernel into memory and then turn over execution to the kernel. GRUB supports multiple Linux kernels and allows users to select between them at boot time using a menu.
	• An introduction to GRUB2 configuration for your Linux machine | Opensource.com
	• Headless software (e.g. "headless Java" or "headless Linux",) is software capable of working on a device without a graphical user interface (GUI). Such software receives inputs and provides output through other interfaces like network or serial port and is common on servers and embedded devices.
	• What is headless system? - Definition from WhatIs.com (techtarget.com)
	• How to Mount ISO File on Linux | Linuxize
	What is the checksum of a file?
	A checksum is a string of numbers and letters that's used to “check” whether data or a file has been altered during storage or transmission. Checksums often accompany software downloaded from the web so that users can ensure the file or files were not modified in transit.
	An ISO file is an archive file that typically contains the complete image of a CD or DVD. For example, most operating systems such as Windows, Linux, and macOS are distributed as ISO images.
	What does LSB do in Linux?
	The LSB (Linux Standard Base) is a project which aims to standardize many of the basic software system structures of Linux. It is based on (and extends) several open standards, such as POSIX. Among the LSB's goals is to standardize Linux, such that software can run in compiled form on any compliant Linux distribution.
	Linux Standard Base - Wikipedia
	•  

From <https://mail.google.com/mail/u/0/#inbox/FMfcgzGpGdmnvpkrmGPHvDwXZtxVKSnM> 

