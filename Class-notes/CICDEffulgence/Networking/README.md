This is a readme file on explaination on how the above infrastructure works

```shell
cd Downloads/DevOPS/NG-Repo/CICDEffulgence/Networking
```

## Create stack

```shell-scipt
aws cloudformation create-stack --template-body file://vpc.yaml --cli-input-json file://param-files/vpc-param.json
```
