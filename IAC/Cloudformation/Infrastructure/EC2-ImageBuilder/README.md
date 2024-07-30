To run the pipeline do the following:
```shell
cd /c/Users/kbrig/Downloads/NG-Repo/EC2-ImageBuilder
```
Now run the following cloudformation template 
```shell
 aws cloudformation create-stack --template-body file://main.yaml --cli-input-json file://Imagebuilder.json --capabilities CAPABILITY_NAMED_IAM
```
