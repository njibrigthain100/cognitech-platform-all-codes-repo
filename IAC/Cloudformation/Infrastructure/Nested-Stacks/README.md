    DEPLOYING A 3 TIER ARCHITECTURE AND SUPPORTING SERVICES USING CLOUDFORMATION NESTED STACKS

![1727753012796](image/README/1727753012796.png)

### SYNOPSIS:

    This project will allow you to deploy a 3 tier architecture (app, web and database server) with supporting resources for infrastructure maintenance. This project assumes that you are familar with basic aws services, linux and github.

### **RESOURCES TO BE CREATED UPON COMPLETION OF THE PROJECT:**

##### *Networking:*

* 2 vpcs ( shared services and app vpc)
* 2 private and 2 public subnets per vpc
* 2 nat gateways in each public subnet per vpc
* 2 nat gateways in each public subnet per vpc
* 1 transit gateway for connection between app and shared services vpc

##### *Compute:*

* 1 windows active directory server
* 1 ssh bastion security group
* 1 rdp bastion security group
* 1 active directory security group
* 1 alb security group
* 1 nlb security group
* 1 windows app security group
* 1 linux app security group
* 1 windows web security group
* 1 elastic file share (efs) security group
* 1 windows file share (fsx) security group
* IAM roles for bastion, active directory server, app, web and database servers
* Application load balancer (ALB)
* Network load balancer (NLB)
* 1 window and 1 linux app server
* 2 windows and 2 linux web servers
* 1 windows database server
* 1 FSX share
* 1 EFS share
* Instance scheduler

##### *Support:*

* AWS Mnaged Microsoft directory service
* 3 system manager documents
* Data lifecycle Manager (DLM)
* 3 system manager association for automation
* System manager maintenance window
* Secrets manager secret for linux domain join
* DNS records for servers and load balancers
* AWS Backup

### WARNING:

* This project includes resources that may incur charges if left running. Please proceed with caution

### STACKS LAYOUT EXPLAINED:

* The project is divided into three distinct folders: ***Initiate-Account***, ***Onboard-resources***, and ***cots-tools***. Each folder relies on the successful deployment of the previous one and should be deployed sequentially. There are specific tasks that must be completed before progressing to the next stack, which will be detailed below. The deployment order is as follows

  1. initiate-account
  2. onboard-resources
  3. cots-tools
* Each folder contains several files along with a main.yaml file, which orchestrates the deployment of all child stacks. Each file is named according to the resources it creates; for example, backup.yaml provisions the AWS Backup service, while bastions.yaml sets up the bastion servers. This naming convention simplifies the identification of where each resource is being created. The files are invoked in the main.yaml file as illustrated below.

  ![pic-9](./Pictures/stack-pic-10.png)

  ![pic-9](./Pictures/stack-pic-11.png)

### PREREQUISITES:

The following preconditions will have to be met for succesfull completion of the project:

#### 1. *Cloning the repo:*

* The repository is available [here](https://github.com/njibrigthain100/cognitech-platform-all-codes-repo) and contains all the necessary stacks for the project. You can refer to this [Git cheat sheet](https://education.github.com/git-cheat-sheet-education.pdf) for frequently used github commands
* After successfully cloning the repository, download all files and folders from the IAC\Cloudformation\Infrastructure\Nested-Stacks directory.

#### ***2. S3 bucket creation:***

* All resources for stack creation are going to be stored in an s3 bucket. Please see [here](https://docs.aws.amazon.com/AmazonS3/latest/userguide/GetStartedWithS3.html) on how to create an s3 bucket.
* Create multiple folders as shown below in the bucket. These folders will be used to store the yaml files for resource creation
  ![pic-1](./Pictures/stack-pic-1.png)
* The above folders have to be named exactly as shown as these are referenced in the cloudformation templates.
* For each of the above folders upload all the files in the corresponfing folders from the github repository that was downloaded in the first step. For instance all files in Initiate account from the github repository should be uploaded to the Initiate-Account in the s3 bucket folder as shown below.

  ![pic-9](./Pictures/stack-pic-12.png)
* now add the name of the s3 bucket to the main.yaml file in each of the folders as shown below:
  ![pic-2](./Pictures/stack-pic-2.png)

#### ***3. Parameter creation:***

* To streamline the process and avoid repeatedly referencing commonly used parameters across multiple templates, we will store them in the parameter store. The parameters include::
* /standard/AWSAccount
* /standard/AWSAccountLC
* /standard/SharedServicesVpc
* Below are the steps to create a parameter in AWS Systems Manager Parameter Store and how to integrate it into your CloudFormation template:

  ![pic-3](./Pictures/stack-pic-3.png)

  ![pic-4](./Pictures/stack-pic-4.png)

  ![pic-5](./Pictures/stack-pic-5.png)

  ![pic-6](./Pictures/stack-pic-6.png)

#### **4. System manager document creation:**

* The Systems Manager documents serve various purposes, such as domain joining newly created instances and adding new Linux servers to the sudoers file. These documents are created via CLI commands, as demonstrated below.
* All SSM documents are located in the SSM-Doc folder.
* After downloading all files and folders to your local machine, navigate to the SSM-Docs directory and run the following commands to create the documents
* LinuxCloudAdmins:

```bash
  aws ssm create-document --content file://CloudAdminSudoersFile.yaml --name "LinuxCloudAdmins" --document-type "Command" --document-format YAML
```

* LinuxPackageInstall:

```bash
  aws ssm create-document --content file://Linuxpackageinstall.yaml --name "Linuxpackageinstall" --document-type "Command" --document-format YAML
```

* AWXInstallation:

```bash
  aws ssm create-document --content file://awx.yaml --name "awxinstallation" --document-type "Command" --document-format YAML
```

![pic-7](./Pictures/stack-pic-7.png)

#### *5. Route 53 domain creation:*

* A domain is needed to house all the dns records that will be created during the project. Please see [Register a new domain](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html) on how to create a new domain in aws route 53
* Once the domain has been created and verifed create a public hosted zone. Please see [Creating a public hosted zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html) on how to create a public hosted zone.
* Once done add the hosted zone Id to the main.yaml file in the Initiate-Account and Onboard-resources as shown below

![pic-8](./Pictures/stack-pic-8.png)![pic-9](./Pictures/stack-pic-9.png)

#### ***6. SSL Certificate creation:***

* An SSL certificate must be associated with the application and network load balancers during their creation. This SSL certificate can be generated using AWS Certificate Manager (ACM) as outlined below. Once the certificate is created, its ARN should be added to the main.yaml file in the onboard-resources folder. For more information on creating an ssl certificate using AWS certificate manager please see [here](https://medium.com/@sonynwoye/creating-ssl-certificates-using-aws-certificate-manager-acm-1c359e70ce4d).
* The certificate ARN should now be added to the `main.yaml` file within the `onboard-resources` directory, as demonstrated below.

  ![pic-9](./Pictures/stack-pic-13.png)
* Consider creating a wildcard certificate for your domain, as this will secure all subdomains associated with it. Refer to the example of a wildcard certificate shown below

  ![pic-9](./Pictures/stack-pic-14.png)

#### ***7. Secrets manager secret creation:***

* Several secrets are required during the creation of all resources in this project. Some are generated during stack deployment, while others need to be created beforehand. Below are the secrets that must be created prior to stack deployment, as the information they hold is essential for the process
* For more information on creating secrets in Secrets Manager, please refer to the following [documentation](https://docs.aws.amazon.com/secretsmanager/latest/userguide/create_secret.html)
* All the secrets created for this project are of the type "***Other type of secret***"
  ![pic-9](./Pictures/stack-pic-15.png)
* The above secrets must be named exactly as shown. If any names are changed, the values must also be updated in the `main.yaml` file located in the `initiate-account` directory, as demonstrated below.

  ![pic-9](./Pictures/stack-pic-18.png)

  - Add the following key-value pairs to your secrets, as illustrated below

  ![pic-9](./Pictures/stack-pic-16.png)

  ![pic-9](./Pictures/stack-pic-17.png)

### ORDER OF STACK DEPLOYMENT:

* The resources in this project are deployed in three steps. There are three folders containing the YAML files for the deployment of all resources for each step. They are:
  * ***Initiate Account folder***:

    * This folder contains the YAML files for creating foundational resources such as VPCs, subnets, internet gateways, NAT gateways, and more. Most resources that will be created will depend on these, so make sure there are no errors during this process.
  * ***Onboard-resources folder:***

    * This folder contains the YAML files for the creation of compute resources, including application servers, web servers, database servers, and more.
  * ***Cots-tools folder:***

    * This folder contains the YAML files for creating support resources, including Windows File Shares (FSx), Linux File Shares (EFS), instance schedulers, and more.
  * ***SSM-Docs folder:***

    * This folder contains all the Systems Manager documents required for the project.

### DEPLOYING  THE STACKS:

* Please see belwo on steps on how to deploy all the stacks for the project.

![pic-1](./Pictures/cfn-pic-1.png)

![pic-2](./Pictures/cfn-pic-2.png)

![pic-3](./Pictures/cfn-pic-3.png)

![pic-4](./Pictures/cfn-pic-4.png)

![pic-5](./Pictures/cfn-pic-5.png)

![pic-6](./Pictures/cfn-pic-6.png)

* You should see the following resources upon succesful deployment of the stacks:
  * An app and shared services vpc with 2 private and 2 public subnets in each vpc
  * 4 ealstic Ip, 4 Nategateway and 2 internet gateway
  * 1 rdp and 1 ssh bastion
  * 1 active directory server
  * IAM roles for active directory and bastions
  * Security groups for bastions and active directory server
  * AWS Backup
  * System manager maintenance window
  * Directory service
  * Secrets for Linux server domain join
  * SSM associations for domain join, linux package install, linux user addition to sudoers file and awx installation
  * Transit gateway for vpc peering between both vpcs
  * DNS records for active directory master, rdp and ssh bastions

#### ACCESSING THE ACTIVE DIRECTORY SERVER FOR CONFIGURATIONS:

* This step must be completed before launching the next set of stacks, as they depend on the configurations made here
* The Active Directory master server has been configured as a domain controller and therefore contains all the necessary packages for Active Directory management
* All users, groups and GPOs (group policy objects) will be created from this server.
* Access to the servers can only be obtained through the bastions. There are two bastions: one for SSH and another for RDP
* RDP bastions are designated for Windows access, and SSH bastions are for Linux access. However, we will be using the SSH bastion to tunnel into our Windows servers, since RDP bastions can only support two concurrent users with a licensePlease, whereas SSH bastions can handle around 50 users at once
* See below for instructions on access and active dircetory setup

###### **ACCESS THROUGH RDP BASTION:**

- See below on how to access the servers using the rdp bastion

![pic-1](./Pictures/init-pic-1.png)

![pic-2](./Pictures/init-pic-2.png)

![pic-3](./Pictures/init-pic-3.png)

![pic-4](./Pictures/init-pic-4.png)

![pic-5](./Pictures/init-pic-5.png)

![pic-6](./Pictures/init-pic-6.png)

![pic-7](./Pictures/init-pic-7.png)

![pic-8](./Pictures/init-pic-8.png)

![pic-9](./Pictures/init-pic-9.png)

![pic-10](./Pictures/init-pic-10.png)

###### **ACCESS THROUGH SSH BASTION:**

* Access through the SSH bastion is achieved using PuTTY and requires tunneling. Please see below for instructions on how to tunnel into a server using PuTTY

  ![pic-11](./Pictures/init-pic-11.png)

  ![pic-12](./Pictures/init-pic-12.png)

  ![pic-13](./Pictures/init-pic-13.png)

  ![pic-14](./Pictures/init-pic-14.png)

  ![pic-15](./Pictures/init-pic-15.png)

![pic-16](./Pictures/init-pic-16.png)

![pic-17](./Pictures/init-pic-17.png)

![pic-18](./Pictures/init-pic-18.png)

![pic-19](./Pictures/init-pic-19.png)

![pic-20](./Pictures/init-pic-20.png)

![pic-21](./Pictures/init-pic-21.png)

###### CONFIGURING THE AD MASTER SERVER:

* Several configurations must be completed on the domain controller before deploying the next set of stacks, as the servers created during this phase will inherit these configuration changes. The adjustments made will include...:
  * Creating AD users and adding them to groups
  * creating a GPO to allow remote RDP access to the newly created servers
  * adding the CloudAdmins groups to the local administrator group and the CloudUsers to the local user groups
  * See below on how to accomplish all 3 steps

![pic-1](./Pictures/ad-pic-1.png)

![pic-2](./Pictures/ad-pic-2.png)

![pic-3](./Pictures/ad-pic-3.png)

![pic-4](./Pictures/ad-pic-4.png)

![pic-5](./Pictures/ad-pic-5.png)

![pic-6](./Pictures/ad-pic-6.png)

![pic-7](./Pictures/ad-pic-7.png)

![pic-8](./Pictures/ad-pic-8.png)

![pic-9](./Pictures/ad-pic-9.png)

![pic-10](./Pictures/ad-pic-10.png)

![pic-11](./Pictures/ad-pic-11.png)

![pic-12](./Pictures/ad-pic-12.png)

![pic-13](./Pictures/ad-pic-13.png)

![pic-14](./Pictures/ad-pic-14.png)

![pic-15](./Pictures/ad-pic-15.png)

![pic-16](./Pictures/ad-pic-16.png)

![pic-17](./Pictures/ad-pic-17.png)

![pic-18](./Pictures/ad-pic-18.png)

![pic-19](./Pictures/ad-pic-19.png)

![pic-20](./Pictures/ad-pic-20.png)

![pic-21](./Pictures/ad-pic-21.png)

![pic-22](./Pictures/ad-pic-22.png)

![pic-23](./Pictures/ad-pic-23.png)

![pic-24](./Pictures/ad-pic-24.png)

![pic-25](./Pictures/ad-pic-25.png)

![pic-26](./Pictures/ad-pic-26.png)

![pic-27](./Pictures/ad-pic-27.png)

![pic-28](./Pictures/ad-pic-28.png)

![pic-29](./Pictures/ad-pic-29.png)

![pic-30](./Pictures/ad-pic-30.png)





























---
