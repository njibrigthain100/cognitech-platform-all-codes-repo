• Provisioning is creating the infrastructure. Example of IAC is CloudFormation and terraform. The process of installing packages and software is known as configuration. This is our infrastructure configuration. 
	- For example you have 100 servers and you need to install wget, vim, tree and nano into these servers how do you do this?
• You can either do this by sshing into each server and run the scripts into each one of them individually. This is the manual way of doing it
• Or you can do it via a configuration management tool which helps you automate the whole process. An example of a configuration management tool is ansible, chef, puppet

WHAT IS ANSIBLE
- Its an open source configuration management, deployment and provisioning automation tool maintained by Redhat
- It is very, very simple to setup and yet powerful
- Ansible will be helpful to perform: Configuration management, application deployment, task automation, IT orchestration
- Ansible playbook can automate your tasks
- Ansible works by remote installing packages to remote nodes(hosts) from the master(control) node
- So installing a package in the control node lets you install it on the other nodes as well
- It does this by pushing small programs called "ansible modules" to the remote nodes
- The control nodes needs an ssh connection to the remote nodes to push the modules. Once the modules are executed on the remote nodes they are removed. 
- It does use an agent on the remote host unlike puppet and chef. Instead it uses SSH. It is agentless
- It is written in python which needs to be installed on the remote hosts
- The ansible software ins only installed on the control node. No software are installed on the remote nodes
- Ansible is a python based product. Ansible automatically install python once you install it.
- The control node will need information about the servers that it is controlling. This is the inventory file in the hosts. This tells the controller the number of nodes it is supposed to be managing.
- The inventory file will have a list of ip addresses or DNS names that ansible is managing
- Ansible also comes with a configuration file (Ansible.cfg). This file tells the controller node where the inventory file is and what the credentials are for for these nodes.
- Ansiible.cfg is key to running ansible. Once a command is run ansible looks for the configuration file to see what actions it is supposed to take.
- An ansible playbook is a collection of ad-hoc commands which will be performed on your hosts servers
Benefits of using ansible
	1. Its free open source automation tool and simple to use
	2. It uses existing openssh for connection
	3. It is agent-less so no need to install any agent on the ansible clients/nodes
	4. It is python/YAML based
	5. It is highly flexeble and versatile in configuration management systems
	6. Large number of ready to use modules for system management
	7. Custom modules can be added if needed
Ansible is only designed to run on Linux or Unix systems meaning the control node needs to be a Linux/Unix system. It is however able to control all types of operating systems like windows, linux etc.
Ansible can be installed in 3 ways:
- Using yum or apt
- Using pip
- Using a compile file

To install ansible do the following
- The following steps are done on both the master and slave nodes
- Create a user called ansible.
	• Sudo adduser ansible in ubuntu
	• Sudo useradd ansible in redhat
- Give the ansible user sudo privileges
	• Echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible \ in ubuntu
	• Echo "ansible ALL=(ALL) NOPASSWD:ALL " | sudo tee /etc/sudoers.d/ansible \ in redhat
- Change to the ansible user
	• Sudo su - ansible for ubuntu
	• Sudo su - ansible # enable passwordLogin and assign password to ansible user in redhat
	• Go to /etc/ssh/ssh_config file and change PasswordAuthentication to yes in all servers and restart the sshd service by tunning sudo systemctl restart sshd in all servers after finishing
- The following steps are done on the master node only
- Install ansible software
	• Sudo apt-add-repository ppa:ansible/ansible for ubunutu : This updates our ubuntu server
	• Sudo apt install ansible -y for ubuntu
	• Sudo apt install python3-pip -y for ubuntu
	• Sudo pip install boto boto3
	• Sudo apt-get install python-boto -y
	
	• Sudo yum install python3 -y for redhat
	• Sudo alternatives --set python /usr/bin/python3
	• Sudo yum -y install python3-pip -y
	• Pip3 install ansible --user
Ansiblenode1: AL2
Ansiblenode2: Redhat
Ansiblenode3: ubuntu
Ansible creates a default home in /etc/ansible which consist of ansible.cfg, hosts and roles. The ansible-ubuntu is the server with the ansible home. 
The configuration file is pointing to your hosts file. This is where ansible knows where to get the server to configure. You can change the inventory file to another path
Ansible looks for the configuration file in the following order:
- Ansible_config environmental variable
- ./ansible.cfg from the current directory. This is in case if different configuration files in different environments
- ~./.ansible.cfg present in the home directory
- /etc/ansible/ansible.cfg default ansible.cfg file

Host key checking?
Anytime you make an ssh connection with a server for the first time, you will be prompted to confirm if you want to continue making the connection. This feature is by default set to true in the ansible.cfg file. 
- You can either disable this by uncommenting out the line in the configuration file or export ANSIBLE_HOST_KEY_CHECKING=false
- The inventory file is where ansible saves all the servers its going to manage
- You can input either the private or public IP in the inventory file. The private IP does not change after you stop the instance but the public IP does so that’s why its better to put the private IP in the inventory file
- The names given to the servers in the inventory file can be anything. They can range from app servers, db servers or web servers. 
Ansible engine uses SSH connection in 2 ways:
- Password authentication: Here the user needs to have a password. Password authentication must be enabled on these servers for the ansible master to be able to connect with the remote server. 
- Password-less authentication (This is with SSH keys): No password is required here but we need SSH keys

Connecting to ansible hosts:
- After you have configured all the servers are annotated above you can add your hosts servers IP to the ansible host file. Vi into the hosts file and create a group name in there and paste the private IP for all your servers under that group.
- Go to the configuration file and make the following changes. 
	• Uncomment the path for the inventory file and host_key_checking. Save and quit after
- Now to connect to the host files run the command ansible groupname -m ping -k
- The k flag here lets you pass the ansible password that you created earlier hence letting you connect to the host servers. Example command will be ansible group1 -m ping -k
- The -k in ansible lets you provide the password in ansible
- The master node discovers that python is installed in the other servers
- Small k prompts you for ssh connection password
- To pass a connection to multiple groups in the hosts file you can run the command as ansible group1:group2 -m ping -k
- By default in ansible there is a group called all so instead of typing the groups in the hosts file individually we can just run the command ansible all -m ping and it captures all the servers in the host file
- If you create a different user in one of the servers you need to create the same user in the master server as this user will be looking to ssh into the same user in the hosts file
- With managed nodes we can use password authentication or password less authentication

Creating a different user in one of our managed nodes
- To do this you create a different user in one of the hosts servers and provide a password for said user.
- Now to connect to this user from the master node run the command ansible groupname -m ping -u username -k where -u is the flag to provide the user name. an example will be ansible group1 -m ping -u bk -k

Host and group variables
- If we run the ping command on all servers we will get permission denied on the servers that need a password to authenticate
- Instead of that we can provide the password in the host file
- This can be done at the host level or group level
- To do this go to the /etc/ansible/hosts file and add this entry next to the host private IP. 
- 172.31.70.117 ansible_ssh_user=bk ansible_ssh_pass=bk this will always provide the password for user bk in this server. In this case I don’t need to specify the user as it automatically knows the user it should connect to based on the password provided for the host
- For 172.31.74.58 ansible_ssh_user=ansible ansible_ssh_pass=ansible for group 2 the password has been provided for user ansible so the server will automatically connect to this user
- The above example is an example of a host variable

Group variables
- This is when you put an ansible password on a group. For example passing the password for group1 in your hosts file
- No need to pass the -k option

Testing for connection between ansible master and the managed hosts
- Create a file on the master node using the command ansible all -m file -a "path=test.txt state=touch"
- This command should create a new file on all your managed nodes
- Any server that doesn’t have a variable defines in it will fail the above command because we haven't passed the -k option to provide a password
- We are able to define the users in which we want all the modules to be ran to. For instance the test3.txt for me was  created under the home of user bk because that is the user's variable that was passed for that host.
- To change the permission of the files in the user you can run the command ansible all -m file -a "path=test4.txt state=touch mode=0600"
- The files usually comes with a default permission of 0644

Parent and children group
- You are also able to create a parent group that has children groups in them. For instance you can create a parent group named app and place groups1 and 2 in said group
- The way it will be placed in the hosts file is as follows
- [app:children] group1 group2

PASSWORDLESS AUTHENTICATION
- To authenticate to the hosts servers without a password generate ssh keys on your ansible master by running the command ssh-keygen. This is done from the home of ansible on the master server
- Copy the ssh public keys using ssh-copy-id hostname of managed node. Example is ssh-copy-id 172.31.70.117 We copy the public keys to the hosts server because the master server has the private keys which will pair with the public keys on the managed nodes. 
- To copy the keys from the master node to a particular user in one of the managed nodes you need to pass the users name@ip address of the server. For example user bk will be ssh-copy-id bk@172.31.70.117
- To ping a specific user on that server you can do so by running ansible group1 -m ping -u bk where bk is the user you are trying to ping
- This is the manual way to do so. In dynamic inventory we will use a script that runs on the console getting the latest IP address and passing it in the inventory file

Ad-hoc commands in ansible
- This is a one liner ansible command that performs one task on the hosts or groups
- Unlike playbooks which consist of a collections of tasks that can be reused ad hoc commands are tasks that you don’t perform frequently, such as starting a service or retrieving information about the remote systems that ansible manages
- The ad-hoc command only has 2 parameters: The group /target hosts that you want to perform the tasks on and the ansible module to run such as ping

Modules
These are small programs that do some work on the server. They are the main building blocks os ansible and are basically reusable scripts that are used by ansible ad-hoc and playbooks. Ansible comes with a number of reusable modules
- You can create a new configuration file in your present working directory. All you need to do is copy the inventory file from the ansible directory and rename it in your pwd. Now point the inventory file in the config file to get info from this new inventory file. This is how it will look in the inventory file.
- Inventory = ./dev.cfg. Now run the ansible command with the -v option to see mre options
- -vv give you more information on a Linux CLI
- You can create an inventory for each environment such as dev, qa, prod etc and let the config file point to the correct host file
- To run a command with a custom host file run with -I option to specify where the inventory is although the config is reading from the default location

TYPES OF MODULES
Command module(-a)
- Used to execute binary commands
- It is the default module that is used when not specified
- With the command module the command will be executed without being proceeded through a shell. Consequently some variables like $HOME and operation like <, >, | and & will not work. The command module s more secure because it will not be affected by the users environment
- This module is limited because of it not being processed through a shell

Shell module (-m)
- This module is superior to the command module
- Commands will be executed being proceeded through a shell
- For example the command ansible group1 -a "cat /etc/hosts && pwd" will fail in the command module due to the && as it does not accept these values but will succeed in the shell module.
- Command in the shell module will be ansible group1 -m shell -a "cat /etc/hosts && pwd"
- -a in these ansible commands just means that you are trying to pass an argument

File module
- This module is used to create files and directories
- For instance to create a file named file25.txt you run ansible group1 -m file -a "path=/home/ansible/file25.txt sate=touch"
- This creates a file in /home/ansible
- To create a director run the command ansible group1 -m file -a "path=/home/ansible/foldername state = directory mode=777 owner=root group=root --become"
- We use the become option here because to create a folder you need to become root to do so
- For folder you don’t need to pass the /home/ansible/folder name as the path as that will create a home, ansible and folder. So instead just run path as path=foldername
- To delete a file or directory the state is absent. 

Copy module:
- This module is sued to copy files from ansible control node to the remote node or copy files from one location to another in the remote node
- An example is ansible group1 -m copy -a "src=/source/file/path dest=/dest/location". Example is ansible group1 -m copy -a "src=/etc/ansible/hosts dest=/home/ansible/new_host"
- The above command copies files from the master node to the remote or managed nodes. 
- Here new_host is the new name for the file to be created in the destination
- To copy a file within the same server run the command as ansible group1 -m copy -a "src=/etc/ansible/hosts dest=/home/ansible/file8.txt remote_src=yes"
- This copies the files from one directory in a managed node to another directory within the same managed node

Fetch module:
- This module is used to download files from a remote node to the control machine
# Ansible group1 -m fetch -a src=/home/ansible/file7.py dest=/home/ansible/file8.txt"

Yum module
- Used to install a package in the ansible client
# - Ansible group1 -m yum -a "name=httpd state=present" --become"

The service module
- Used to manage services running on remote nodes
- For instance to start apache you use the service module to start it
- Ansible group1 -m service -a "name=nginx state=started" --become

User Module
- This module is used to create a user account
- To create a user you have to create a password first and encrypt it
- This is done through openssl passwd crypt <desired passwd>
- To do so run ansible group1 -m user -a "name=Peter password=xnsnkmkxsx shell=/bin/bash" -b
- That’s how you create a user

Setup module
- This gives us information about the managed nodes
- This is a default module and is used to gather facts about the hosts
- The setup module returns detailed information about the remote systems managed by ansible, also known as system facts
- To get information run ansible group1 -m setup
- To apply a filter run ansible group1 -m setup -a "filter=ipv"

Debug module
- The debug module on the local host to display some information about/message or variable value.
- We do not need ssh connectivity or password for the debug module. When using the debug module the arguments with either be -msg to display a message or var to display a variable
- Ansible all -m debug -a "var='inventory_hostname'" to display the hostname for all my managed nodes
- The variable group displays all the groups within my inventory ansible all -m debug -a "var=,group'" or ansible all -m debug -a "var=groups.keys()'" to only display the group keys
- You can use the shell command to display the memory for all your managed nodes by running ansible all -m shell -a "df -h"


Ansible class 2
Ansible playbook:
- A playbook can declare a configuration
- Orchestrate steps of any manual ordered process on multiple sets of machines in a defined order
- Launch tasks synchronously or asynchronously
- Expressed in YAML format
- To write a playbook you start with 3 hyphens at the top
- So after the hyphens you declare what your hosts is. In my case its group1
- Next is declaring the tasks. This is what you want to accomplish
---
  - hosts: group1
    tasks:
      - apt: name=apache2 state=present
        become: yes
- So create a file on your server and write the playbook within that file
- To run an ansible playbook run ansible-playbook plus playbook name. example is ansible-playbook playbook.yaml
---
  - name: This play is to install httpd on the group2 servers
    hosts: group2
    tasks:
      - name: Install httpd
        yum: name=httpd state=present
        become: yes
- The above example is when you want to provide a name to both the play and the tasks

--- 
- name: Installing and starting httpd on servers in group2
  hosts: group2
  tasks:
  - name: Install https
    yum:
     name: apache2
     state: present 
    become: yes  
  - name: Start httpd 
    service:
      name: httpd 
      state: started 
    become: yes
     
- The above playbook installs and starts httpd on servers in group2
- You can put become at the host level so that all your tasks are going to be run as root

--- 
- name: Installing and starting httpd on servers in group2
  hosts: group2
  become: yes
  gather_facts: false
  tasks:
  - name: Install httpd
    yum:
     name: apache2
     state: present 
  - name: Start httpd 
    service:
      name: httpd 
      state: started 

- The playbook prevents us from running multiple ad-hoc commands
- To disable gathering facts you can add gather_facts: false in the playbook
- The yaml files have to indented correctly if not you will get an error. 
- The debug module lets you gather info after outputting it

--- 
  - name: To install httpd or apache2
    hosts: group1
    become: yes
    tasks:
    - name: Installing apache2 on ubuntu servers 
      apt: 
        name: apache2
        state: present
      when: ansible_distribution == "Ubuntu"
    - name: Installing httpd on rhel servers
      yum:
        name: httpd 
        state: present
      when: ansible_distribution != "Ubuntu"
- For the above playbook when lets ansible know what package manager to use depending on OS. So when ubuntu use apt and when RHEL use yum
- When is a condition statement in this case
- Stdout is standard output 

--- 
- name: Finding os ditribution and os name
  hosts: all
  gather_facts: false
  tasks: 
  - name: Finding os ditribution 
    shell: "cat /etc/os-release | awk -F = 'NR==1 {print $2}' | awk '{print $1}' | tr '\"' ' '"
    register: os_dist
  - name: Finding os_name
    shell: "uname"
    register: os-name
  - debug:
    msg:
      - "The os distribution name is: {{os_dist.stdout}}"
      - "The os name: {{os_name.stdout}}"
- You can accomplish the same results as the above playbook by enabling gather_facts

--- 
  - name: Gathering info with debug module
    hosts: group1
    tasks:
    - name: Memory info
      shell: df -h
      register: results 
    - debug:
        var: results
- The above playbook can be used to get memory info from a server and output the results in a variable file called results using the debug module

--- 
- name: Installing multiple packages on RedHat and Debian
  hosts: all
  become: yes
  gather_facts: true 
  tasks:
  - name: Installing httpd on RedHat
    yum:
      name: httpd 
      state: present
    when: ansible_os_family=="RedHat" 
  - name: Starting the httpd on the server 
    service: 
      name: httpd 
      state: started 
    when: ansible_os_family=="RedHat"
  - name: starting the apache2 on ubuntu 
    service: 
      name: apache2 
      state: started 
    when: ansible_os_family=="Debian"
  - name: Installing apache2 on Debian servers 
    apt: 
      name: apache2 
      state: present
    when: ansible_os_family=="Debian" 
  - name: installing java-1.8.0-openjdk on RedHat servers 
    yum: 
      name: java-1.8.0-openjdk 
      state: present 
    when: ansible_os_family=="RedHat" 
  - name: Installing git on RedHat family
    yum: 
      name: git 
      state: present 
    when: ansible_os_family=="RedHat"
  - name: Installing tree on Debian os family 
    apt: 
      name: tree 
      state: present 
    when: ansible_os_family=="Debian"
  - name: Copying from master to hosts 
    copy:
      src: /home/ansible/testing.txt
      dest: /home/ansible/testing1.txt
  - name: creating a directory
    file:
      path: foler99
      state: directory
      mode: 777
      owner: root
      group: root

Import or include:
- Here you create different tasks for different functions
- Here we have multiple playbook all performing different task and in the main template we import all the other playbooks. For instance we have a playbook installing httpd on RedHat servers and another installing apache2 on Debian servers. We then import all these playbooks to the main playbook as shown below

---
  - name: Installing packages on Debian and RedHat servers
    hosts: all
    gather_facts: true
    become: yes
    tasks:
      - import_tasks:
          install_httpd.yaml
         when: ansible_os_family=="RedHat"
      - import_tasks:
          install_apache2.yaml
          when: ansible_os_family=="Debian"
- Here the tasks is ran in all servers if not specified in the child tasks
- What's the difference between import tasks and include tasks: Import tasks will import the tasks if it has static content. So here the values do not change
- Include tasks are used when the tasks are dynamic. That means the variables are constantly changing
- For the above playbook you can simplify it by passing a variable in the import tasks that allows it to dynamically get the operating system as it runs as below

---
  - name: Installing packages on Debian and RedHat servers
    hosts: all
    gather_facts: true
    become: yes
    tasks:
      - include_tasks: install_{{ansible_os_family}}.yaml
      - include_tasks: install_{{ansible_os_family}}.yaml
      - include_tasks: install_{{ansible_os_family}}.yaml
- Here you want to make sure that the names you give your child tasks matches the names on the include tasks. For example the name for the first task should be install_Redhat.yaml so that ansible can dynamically pull that tasks as it goes. This makes the playbooks reusable 
- In my case I named all the webservers installation web_OSName.yaml and all the java installation jav_OSName.yaml
- See below

---
  - name: Installing packages on Debian and RedHat servers
    hosts: all
    gather_facts: true
    become: yes
    tasks:
      - include_tasks: web_{{ansible_os_family}}.yaml
      - include_tasks: java_{{ansible_os_family}}.yaml


Loops in ansible
- Instead of writing the tasks as below you can use a loop to make it easier for you
---
 - name: Installing packages on RedHat servers
   hosts: all
   become: yes
   gather_facts: true
   tasks:
     - yum:
        name: git
        state: present
     - yum:
        name: wget
        state: present
     - yum:
        name: pip3
        state: present
     - yum:
        name: tree
        state: present
     - yum:
        name: vim
        state: present 

- So you can loop it by doing this

---
 - name: Installing packages on RedHat servers
   hosts: group1
   become: yes
   gather_facts: true
   tasks:
     - yum:
        name: "{{item}}"
        state: present
        loop:
          - git
          - wget
          - pip
          - tree
          - vim

Ansible class 3

- You can do syntax check in ansible by running the command yaml format = --synatx-check
- To create a dependency between 2 tasks you can do so by using the register and when command as shown below. So in this case register will register the output of the command and when=out.changed will only works once the first command is completed successfully.
---
  - name: Installing httpd on RedHat servers 
    hosts: group2
    gather_facts: true
    tasks: 
      - name: Installing httpd on group2 servers 
        yum: 
          name: httpd 
          state: present 
        register: out 
      - name: Starting httpd on group2 servers 
        service: 
          name: httpd 
          state: started 
        when: out.changed == True 

Handlers
- What are ansible handlers
- The handlers are used for dependencies. So handlers are notified when a tasks is completed in which the second tasks is dependent upon. 
- So in our example we can create a handler to be notified when the httpd is service is installed so that it can start the service. 
- Handlers are on the same line as the tasks
---
  - name: Installing httpd on RedHat servers 
    hosts: group2
    become: yes 
    gather_facts: true
    tasks: 
      - name: Installing httpd on group2 servers 
        yum: 
          name: httpd 
          state: present 
        notify:
          start httpd 
    handlers:
      - name: start httpd 
        service: 
          name: httpd 
          state: started     

- As you can see here the notify option is given a name of the handler and notifies the handler when the service has been installed for the handler to start the service
- So handlers only work when there's a notifier as seen from the green section in the above code
- The index.html file in ansible Is found under usr/share directory

Template modules:
- This is used to transfer dynamic files .i.e files whose data are constantly changing
- To use the template module you need to include a tasks that uses the template module

---
  - name: Installing httpd on RedHat servers 
    hosts: group2
    become: yes 
    gather_facts: true
    tasks: 
      - name: Intsalling httpd on group2 servers 
        yum: 
          name: httpd 
          state: present 
        notify:
          start httpd 
      - name: copy dynamic data 
        template: 
          src: index.html.j2
          dest: /usr/share/httpd/noindex/index.html  
      - name: 
        service: 
          name: httpd 
          state: started 


- The index.html.j2 file looks like this
- Welcome to Landmark Technology from {{inventory_hostname}}
- As you can see the inventory_hostname was passe in as a dynamic variable which can change at anytime. 
- So we use the template module to copy data that is dynamic in nature. Otherwise we can simply use the copy module to do the same thing

Ansible Roles:
- An ansible role lets you automatically load related variables ,files, tasks or handlers within a know structure. 
- In /etc/ansible there's a directory called roles. This is where you can create reusable data and share them with a team.
- To create a role in ansible you run the command ansible-galaxy init plus role name. so for example ansible-galaxy init httpd 
- Galaxy.ansible.com has reusable roles that have already been created and can be reused
- To create a role offline you can run the command ansible-galaxy init rolename --offline
- You have to be root to create a role
- Once you run the command it creates a bunch of directories for you in that role
- The main.yml under the tasks directory is where you keep your main template
- Run tree to see all the directories in the role
- If you have handlers in your playbook you include them in your handlers directory
- Files is where you keep your files and template is where you keep dynamic data
- The variables will go in the vars directory
- When copying and pasting the tasks in the main.yml no need to copy the hyphens at the beginning
- Once you've created the role you need to create a playbook that points to the roles as seen below. In place of tasks we have the role name
---
 - hosts: group1 
   gather_facts: true
   become: yes
   roles: 
     - httpd1  

- This is how each file looked like
- Main.yml for tasks
---
 - name: Intsalling httpd on group2 servers
   yum:
      name: httpd
      state: present
 - name: copy dynamic data
   template:
      src: index.html.j2
      dest: /usr/share/httpd/noindex/index.html
   notify:
          start httpd
- Main.yml for handlers
---
 - name: start httpd
   service:
      name: httpd
      state: started
- Index.html.j2 for template
- Welcome to Landmark Technology from {{inventory_hostname}}
- The above files do not need to have the hyphens as with the main playbook itself. 

Role to Install Tomcat:
- Nohup in linux means no hang up meaning that some programs stay running even after the existing shell or command. 
- Tomcat website is https://tomcat.apache.org 

--- 
  - name: Install and configure tomcat 
    hosts: group1
    gather_facts: true 
    vars: 
      req_java: java-1.8.0-openjdk 
      set_java: jre-1.8.0-openjdk 
      req_tomcat_ver: 10.1.4
      tomcat_url: https://dlcdn.apache.org/tomcat/tomcat-{{req_tomcat_ver.split('.')[0]}}/v{{req_tomcat_ver}}/bin/apache-tomcat-{{req_tomcat_ver}}.tar.gz  
      tomcat_port: 8090
    become: yes 
    tasks: 
    # Role 1: update repos
      - name: updating the repos 
        yum: 
          name: "*"
          state: latest 
    # Role 2: Installing reuiqred java 
      - name: Installing the required java 
        yum:  
          name: "{{req_java}}"
          state: present 
      - name: Setting default java  y
        alternatives: 
          name: java 
          link: /usr/bin/java 
          path: /usr/lib/jvm/{{set_java}}/bin/java
    # Role 3: Download tomcat 
      - name: Downloading required tomcat 
        get_url: 
          url: "{{tomcat_url}}"
          dest: "{{/usr/local}}"
      - name: Extracting downloaded tomcat 
        unarchive:
          src: "/usr/local/apache-tomcat-{{req_tomcat_ver}}".tar.gz
          dest: /usr/local 
          remote_src: yes 
      - name: Renaming tomcat home 
        command: mv /usr/local/apache-tomcat-{{req_tomcat_ver}} /usr/local/latest 
      - name: Replacing defualt port with required port 
        template: 
          src: server.xml.j2 
          dest: /usr/local/latest/conf/server.xml 
        notify: 
            start tomcat 
    handlers:
      - name: start tomcat 
        shell: nohup/usr/local/latest/bin/startup.sh &

- Server.xml can be found at https://github.com/apache/tomcat/blob/main/conf/server.xml
- We have our custome file in the master node which will replace the file in the managed nodes. The custom server.xml has a port of 8090 for security purposes
- The server.xml needs to be transferred inside the template directory
- Go to this site to download the lates version of tomcat: https://tomcat.apache.org/download-10.cgi#10.1.4
- https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.4/bin/apache-tomcat-10.1.4.tar.gz
- From here right click and copy the link for the tar file 
- For the above you can configure tomcat in such a way that it provisions the users and permissions for the user to be able to access the application already

WHAT ABOUT DYNAMIC INVENTORY
- We have been using static inventory this whole time so what happens when the inventory is dynamic? 
- Always use your private IP as they don’t change when the server is stopped. 
- Static inventory are plain text files containing a list of managed hosts/remote nodes. 
- Dynamic means the hosts file keeps changing as new hosts are added or decommissioned
- IP addresses will change as the servers are stopped and started. 
- Because of this ansible offers a way to fetch our host dynamically 
- Managing dynamic inventory in AWS can be done through:
	1. Scripts: to make API calls to AWS. You will have to search for the ec2.py and ec2.ini scripts. These are  python scripts that are able to make API calls to AWS so you can get your inventory. For this you will need to install an sdk (software development kit) aka boto/boto3 to get your inventory. Once boto is installed there are 2 ways in which you can use the script. The first method is through the command line. . For instance ansible -I ec2.py -u ubuntu us-east-1 -m ping. The second option is to copy the script to the /etc/ansible/hosts directory and give it executable permissions. You can find the script at https://github.com/vshn/ansible-dynamic-inventory-ec2/blob/master/ec2.py
	2. The second easier way is through a plugin. This can be found at https://docs.ansible.com/ansible/latest/collections/amazon/aws/aws_ec2_inventory.html.  To use the plugin the following requirements must be met:
		○ Install boto /boto3 /botocore by running sudo apt-get update -y and sudo apt-get install -y python3-boto3
		○ Install the plugin by running the command ansible-galaxy collection install amazon.aws   
		○ You need a role attached to the instance to be able to run that command
		○ After the plugin is installed you need to create YAML configuration file that ends with aws_ec2. yaml. See example in the documentation above. 

Plugin: aws_ec2
region:
  us-east-1
keyed_groups:
  - key: hostname
    prefix: ip-address
  - key: placement.region
    prefix: aws_region
  - key: tag.Type
    separator: ''
  - key: tag.Name
    separator: ''
hostnames:
  - ip-address
  - dns-name
  - tag:Type
  - tag:Name
  - private-ip-address
- The above is how the configuration file for the dynamic inventory looks liks
- After building the above inventory file go to your ansible config file and point the inventory file to this new file
- To check the inventory run the command ansible-inventory --list
- This will show you all the inventory in the region you have configured in the above file
- URGENT: Always make sure to input this in your configuration file enable_plugins = aws_ec2
- Not putting that will not work no matter what you do. This is basically enabling the aws_ec2 plugin to work with the server
- When using dynamic inventory you can input what server you want to make changes on in the playbook. 



 

