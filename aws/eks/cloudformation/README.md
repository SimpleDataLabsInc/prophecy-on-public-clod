## Deploy EKS cluster via cloudformation

**1.** Please click on the below icon to get started. This will take you to AWS Cloudformation page and ask for more inputs for further installation. Please check below points for input details.

By default this link will take you to us-east2 availability zone. Please change the availability zone if you want to deploy the cluster in any other AZ.

[<img src="https://github.com/SimpleDataLabsInc/prophecy-cloudformation/blob/main/amazon_cloudformation_logo_icon_168665.png" width="200"/>](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/new?stackName=Amazon-EKS&templateURL=https://s3.amazonaws.com/aws-quickstart/quickstart-amazon-eks/templates/amazon-eks-entrypoint-new-vpc.template.yaml)


**2**. Please use this template for EKS installation: https://prophecy-public-bucket.s3.us-east-2.amazonaws.com/amazon-eks-entrypoint-new-vpc.template.yaml . Please check below screenshot and replace above URL as Amazon S3 URL:
 
<img width="1144" alt="Screenshot 2022-05-10 at 4 16 06 PM" src="https://user-images.githubusercontent.com/59466885/167611625-93ea3f01-64ae-4f1d-9b59-db196ecdf1c2.png">


**3**. Check out all the availability zones for the subnets in the VPC

<img width="1100" alt="Screenshot 2022-05-10 at 3 53 19 PM" src="https://user-images.githubusercontent.com/59466885/167610427-6d0ce82c-795a-44a3-99a3-273767c9f431.png">

**4**. Please make sure that number of availability zones you chosed in the step 2 is same as this one.
  <img width="991" alt="Screenshot 2022-05-10 at 4 16 35 PM" src="https://user-images.githubusercontent.com/59466885/167611741-b6674fcc-a786-48f2-9c8a-a4fc0ccfd5f4.png">

  
**5**. Please provide EKS cluster name matching with this regex ```[a-zA-Z][-a-zA-Z0-9]*```

<img width="1035" alt="Screenshot 2022-05-10 at 3 56 20 PM" src="https://user-images.githubusercontent.com/59466885/167611360-84bd98c3-ffec-4c18-9786-ef0501eb696b.png">


**6**. Click Next to go to next screen. No mandatory input required here.

**7**. Click Next to go to next screen. No mandatory input required here.
  
**8**. Before creating the stack, please acknowledge to AWS cloudformation conditions by clicking on these checkboxes.
  <img width="1053" alt="Screenshot 2022-05-10 at 4 17 11 PM" src="https://user-images.githubusercontent.com/59466885/167611802-64fcb681-f207-4d62-af7b-afb4cc7fe154.png">

      
**9**. Once cluster is set up, you can add the cluster config via this command
      
   ```aws eks --region us-east-2 update-kubeconfig --name $CLUSTER_NAME --alias $CLUSTER_NAME```
      
   ```kubectl config use-context $CLUSTER_NAME```
  
        
By now, you should be able to access the cluster.
