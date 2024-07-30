This explains how to run the cloudformation template to create the EC2 instance
The First step is to ensure that you run the VPC stack as the instance has some dependencies on that stack

```shell
cd Downloads/DevOPS/NG-Repo/CICDEffulgence/Compute
```

```shell
aws cloudformation create-stack --template-body file://ec2autoscaling.yaml --cli-input-json file://Params/InstanceParam.json --capabilities CAPABILITY_NAMED_IAM
```

The capabilities CAPABILITY_NAMED_IAM option is added because this template is created IAM resources .i.e policies

- To launch a new stack make sure you make changes to the following:
  The output for the instance profile name
  The Instance profile name in the resource
  The output for the instance ID name
