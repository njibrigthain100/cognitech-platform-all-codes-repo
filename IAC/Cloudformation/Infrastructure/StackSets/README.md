This area shows you how to create a stack set cloudformation template to deploy to all your AWS accounts. The prerequisite for doing this is creating an admin role in the admin admin account and an execution role in the target accounts. The admin role assumes the execution role to be able to run the cloudformation stacks in those accounts.  We are using the self managed permissions for this.

* Steps in creation the admin role:

  ```
  aws cloudformation create-stack --template-body file://AWSCloudFormationStackSetAdministrationRole.yml --cli-input-json file://Params/StacksetAdmin.json --capabilities CAPABILITY_NAMED_IAM 
  ```
* Next step is creating the execution role in eac target account.
* ```
  aws cloudformation create-stack --template-body file://AWSCloudFormationStackSetExecutionRole.yml --cli-input-json file://Params/Stacksetexecution.json --capabilities CAPABILITY_NAMED_IAM --profile "profile name here"
  ```
* The above option --profile "profile name here" allows you to pass the profile name to which you want to run the cloudformation template in. Names can be QA, Prod etc
