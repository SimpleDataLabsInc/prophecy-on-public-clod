## Deploy EKS cluster via cloudformation

[<img src="https://github.com/SimpleDataLabsInc/prophecy-cloudformation/blob/main/amazon_cloudformation_logo_icon_168665.png" width="200"/>](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/new?stackName=Amazon-EKS&templateURL=https://s3.amazonaws.com/aws-quickstart/quickstart-amazon-eks/templates/amazon-eks-entrypoint-new-vpc.template.yaml)

## Prerequisites

1. Use this template: https://prophecy-public-bucket.s3.us-east-2.amazonaws.com/amazon-eks-entrypoint-new-vpc.template.yaml as Amazon S3 URL as below:
 
    <image src="https://prophecy-public-bucket.s3.us-east-2.amazonaws.com/Screenshot+2022-04-29+at+11.54.12+AM.png" width="800">

2. Check out all the availability zones for the subnets in the VPC

3. Make sure that number of availability zones you chosed in the step 2 is same as this one.
  
    <image src="https://prophecy-public-bucket.s3.us-east-2.amazonaws.com/Screenshot+2022-04-28+at+1.21.42+PM.png" width="800">
  
4. Make sure to provide EKS cluster name matching with this regex ```[a-zA-Z][-a-zA-Z0-9]*```
  
5. Before creating the stack, make sure to check out these checkboxes.
  
    <image src="https://prophecy-public-bucket.s3.us-east-2.amazonaws.com/Screenshot+2022-04-28+at+1.28.25+PM.png" width="700">
      
6. Once cluster is set up, you can add the cluster config via this command
      
   ```aws eks --region us-east-2 update-kubeconfig --name $CLUSTER_NAME --alias $CLUSTER_NAME```
      
   ```kubectl config use-context $CLUSTER_NAME```
  
7. You can follow this link and create aws creds by clicking Create access Key Under Security Credentials section. Once you have created the creds, you can use those to configure your aws via ``` aws configure```
      
      <image src="https://prophecy-public-bucket.s3.us-east-2.amazonaws.com/Screenshot+2022-04-19+at+5.28.56+PM.png" width="700">
        
By now, you should be able to access the cluster.
