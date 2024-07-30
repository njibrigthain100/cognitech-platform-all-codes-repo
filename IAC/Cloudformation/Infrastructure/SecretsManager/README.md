To create the stack run the following commands:
```shell
cd /c/Users/kbrig/Downloads/NG-Repo/SecretsManager
```
Now run the following cloudformation template 
```shell
 aws cloudformation create-stack --template-body file://main.yaml --cli-input-json file://AmiSecrets.json --capabilities CAPABILITY_NAMED_IAM