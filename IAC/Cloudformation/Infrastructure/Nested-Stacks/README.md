### ***DEPLOYING A 3 TIER ARCHITECTURE AND SUPPORTING SERVICES USING CLOUDFORMATION NESTED STACKS***

![1727753012796](image/README/1727753012796.png)

### SYNOPSIS:

    This project will allow you to deploy a 3 tier architecture (app, web and database server) with supporting resources for infrastructure maintenance. This project assumes that youae familar with basic aws services, linux and github.

### **RESOURCES TO BE CREATED UPON COMPLETION OF THE PROJECT:**

##### *Networking:*

* 2 vpcs ( sharewd services and app vpc)
* 2 private and 2 public subnets per vpc
* 2 nat gateways in each public subnet per vpc
* 2 elastic Ips associated to the nat gateway per vpc
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
* 1 windows we security group
* 1 linux web security group
* 1 elastic file share (efs) security group
* 1 windows file share (fsx) security group
* IAM roles for bastion, active directory server, app, web and database servers
* Application load balancer
* 1 window and 1 linux app server
* 2 windows and 2 linux web servers
* 1 windows database server
* Network load balancer
* 1 fsx share
* 1 fsx share
* instance scheduler

##### *Support:*

* AWS Mnaged Microsoft directory service
* 3 system manager documents
* Data lifecycle Manager
* 3 system manager association for automation
* System manager maintenance window
* secrets manager secret for linux domain join
* DNS A records for bastion and active directory server
* AWS Backup

### STACKS LAYOUT EXPLAINED:

* The project is divided into three distinct folders: ***Initiate-Account***, ***Onboard-resources***, and ***cots-tools***. Each folder relies on the successful deployment of the previous one and should be deployed sequentially. There are specific tasks that must be completed before progressing to the next stack, which will be detailed below. The deployment order is as follows
  1. initiate-account
  2. onboard-resources
  3. cots-tools

* Each folder contains several files along with a main.yaml file, which orchestrates the deployment of all child stacks. Each file is named according to the resources it creates; for example, backup.yaml provisions the AWS Backup service, while bastions.yaml sets up the bastion servers. This naming convention simplifies the identification of where each resource is being created. The files are invoked in the main.yaml file as illustrated below. 

### PREREQUISITES:

- The following preconditions will have to be met for succesfull completion of the project:

  1. ***Cloning the repo:***

  * The repository is available [here](https://github.com/njibrigthain100/cognitech-platform-all-codes-repo) and contains all the necessary stacks for the project. You can refer to this [Git cheat sheet](https://education.github.com/git-cheat-sheet-education.pdf) for frequently used github commands
  * After successfully cloning the repository, download all files and folders from the IAC\Cloudformation\Infrastructure\Nested-Stacks directory.

  2. ***S3 bucket creation:***

  * All resources for stack creation are going to be stored in an s3 bucket. Please see [here](https://docs.aws.amazon.com/AmazonS3/latest/userguide/GetStartedWithS3.html) on how to create an s3 bucket.
  * Create multiple folders as shown below in the bucket. These folders will be used to store the yaml files for resource creation
    ![pic-1](./Pictures/stack-pic-1.png)
  * The above folders have to be named exactly as shown as these are refernced in the cloudformation templates.
  * For each of the above folders upload all the files in the corresponfing folders from the github repository that was downloaded in the first step. For instance all files in Initiate account from the github repository should be uploaded to the Initiate-Account in the s3 bucket folder
  * now add the name of the s3 bucket to the main.yaml file in each of the folders as shown below:
    ![pic-2](./Pictures/stack-pic-2.png)

  3. ***Parameter creation:***

  * To streamline the process and avoid repeatedly referencing commonly used parameters across multiple templates, we will store them in the parameter store. The parameters include::
  * /standard/AWSAccount
  * /standard/AWSAccountLC
  * /standard/SharedServicesVpc
  * Below are the steps to create a parameter in AWS Systems Manager Parameter Store and how to integrate it into your CloudFormation template:

    ![pic-3](./Pictures/stack-pic-3.png)

    ![pic-4](./Pictures/stack-pic-4.png)

    ![pic-5](./Pictures/stack-pic-5.png)

    ![pic-6](./Pictures/stack-pic-6.png)

  4. ***System manager document creation:***

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

5. ***SSL Certificate creation:***

* An SSL certificate must be associated with the application and network load balancers during their creation. This SSL certificate can be generated using AWS Certificate Manager (ACM) as outlined below. Once the certificate is created, its ARN should be added to the main.yaml file in the onboard-resources folder

6. ***Secrets manager secret creation:***

### HOW TO DEPLOY THE INFRASTRUCTURE:

* The resources on this project are deployed in 3 steps. There are 3 folders containing the yaml files for deployment of all the resources for each step. They are:
  * Initiate Account folder:
    * This folder contains the yaml files for creation of the foundation resources such as vpc, subnet, internet gateway, nat gateway etc. Most resources to be created will have a depenedency on these so ensure that there are no errors during this process
    * Onboard-resources folder:
      * This folder contains the yaml files for creation for the compute resources such as the app, web and database servers and much more
    * Cots-tools folder:
      * This folder contains the yaml files for the creation of support resources such as windows file share (fsx), linux file share (efs), instance scheduler and more
    * SSM-Docs folder:
      * This folder contains all the system manager document needed for the project

### WARNING:

* This project contains resources that may accrue charges if left on. Proceed with caution.

###### *SSM Parameter creation:*

###### *SSM Document creation:*

###### *Create a route 53 domain:*

* A domain is needed to house all the dns records that will be created during the project. PLease see [Register a new domain](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html) on how to create a new domain in aws route 53
* Once the domain has been created and verifed create a public hosted zone. Please see [Creating a public hosted zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html) on how to create a public hosted zone.
* Once done add the hosted zone Id to the main.yaml file in the Initiate-Account and Onboard-resources as shown below

  ![pic-8](./Pictures/stack-pic-8.png)

![pic-9](./Pictures/stack-pic-9.png)
