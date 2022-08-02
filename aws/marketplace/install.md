Prophecy IDE can be installed in a new EKS cluster or an existing cluster. 

<img width="596" alt="Screenshot 2022-06-08 at 4 57 27 PM" src="https://user-images.githubusercontent.com/59466885/172617039-3c82e2f6-af50-408d-9c10-b05f18fc636d.png">

### Launch on a new EKS cluster with QuickLaunch
QuickLaunch leverages AWS CloudFormation to configure and create a new Amazon EKS cluster and deploy this software on it. When you choose QuickLaunch with CloudFormation, you will be redirected to CloudFormation to review the cluster configuration before creating it and launching the software. QuickLaunch makes launching software simple and fast so you can test it without needing to worry about infrastructure.

### Launch on an existing cluster
If you already have an EKS cluster and want to deploy Prophecy IDE in the same k8s cluster, please choose this option.

# Permissions & Pre-requisites

### Permission
* If you have chosen the "Launch on a new EKS cluster with QuickLaunch" option, then a new EKS cluster will be created as part of the installation and all the Prophecy resources will be created inside it. You require a role that can install an EKS cluster in your AWS account. An admin role will have all the required permission to install the EKS cluster.  

### Resource Requirements

If you are using Quicklaunch Prophecy IDE requires an EKS cluster with a minimum of 6 t3.2xlarge family types of VMs. Please assign an appropriate quota in your AWS account for a region where you are planning to deploy Prophecy. Please contact the Prophecy team to understand your future scaling needs.

### TLS
As of now, marketplace-based installation supports only Prophecy-managed certificates. In near future, we will support bringing your own domain and certificate option where customer can upload their own certificates during the installation process. 

# Installation
Prophecy provides an easy-to-use visual interface to design and run data pipelines at scale. AWS Marketplace enables Prophecy to offer a deployment route that is easy for consumers to deploy Prophecy IDE. To make a marketplace-based application available to all customers, Prophecy publishes its Kubernetes-based application in the AWS marketplace. Consumers can deploy the required infrastructure with a couple of clicks and get the benefit of automated management and support by the Prophecy team via AWS Marketplace.

## Deploying Prophecy from AWS Marketplace

### Overview
This topic describes how to deploy and launch a Prophecy IDE in AWS from the AWS Marketplace, finish a simple onboarding process and start using our IDE to design and run data pipelines at scale.

The following steps show you how to get Prophecy for AWS up and running via the AWS Marketplace.
![azm](https://user-images.githubusercontent.com/59466885/172621451-8fbe9975-e28b-401a-8b29-8bc68a219413.png)

## Step 1: Pre-requisites

Please check the details in Permissions & Pre-requisites section above. 

## Step 2: Install Prophecy IDE

### 1. Search Prophecy in the Azure Marketplace.
  1. Click on "Continue to Subscribe" and then "Continue to Configure" 
  2. If you don't have any existing k8s cluster where you want to install Prophecy IDE, please choose "Launch on a new EKS cluster with QuickLaunch", otherwise please choose "Launch on an existing cluster"

#### 1.1. Launch on a new EKS cluster with QuickLaunch
1. Click on "Quicklaunch with CloudFormation"
2. Please give StackName, EKS Cluster Name and Customer Name. You can give same name for all the three inputs. Please note down this information.
3. Please choose Instance type as **t3a.2xlarge** and number of nodes, maximum number of nodes as 6. 
4. Please do not edit any other field. Your cloudformation stack input should look like this:

<img width="557" alt="Screenshot 2022-06-08 at 6 32 32 PM" src="https://user-images.githubusercontent.com/59466885/172623143-0ce0c090-d649-4677-b7bd-ac18148a4bf6.png">
5. Please acknowledge to the AWS CLoudformation conditions
6. Click on create stack

#### 1.2. Launch on an existing cluster

##### Create an IAM policy in your AWS account

[More info on how to create a new policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_managed-policies.html#step1-create-policy)

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "aws-marketplace:MeterUsage"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
```

##### Create an IAM role with the appropriate trust relationships
We recommend doing this via eksctl. More detail and how to set up the appropriate trust relationships is available [here](https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html).
```
kubectl create namespace prophecy
            
eksctl create iamserviceaccount \
    --name prophecysametering \
    --namespace prophecy \
    --cluster <ENTER_YOUR_CLUSTER_NAME_HERE> \
    --attach-policy-arn arn:aws:iam::aws:policy/AWSMarketplaceMeteringFullAccess \
    --attach-policy-arn arn:aws:iam::aws:policy/AWSMarketplaceMeteringRegisterUsage \
    --attach-policy-arn arn:aws:iam::aws:policy/service-role/AWSLicenseManagerConsumptionPolicy \
    --approve \
    --override-existing-serviceaccounts
```

#####  Deploy Prophecy with attached IAM role

Please run below command to deploy Prophecy to your EKS cluster.

```
export HELM_EXPERIMENTAL_OCI=1

aws ecr get-login-password \
    --region us-east-1 | helm registry login \
    --username AWS \
    --password-stdin 709825985650.dkr.ecr.us-east-1.amazonaws.com

mkdir awsmp-chart && cd awsmp-chart

helm pull oci://709825985650.dkr.ecr.us-east-1.amazonaws.com/prophecy/prophecy-marketplace --version 2.1.1

tar xf $(pwd)/* && find $(pwd) -maxdepth 1 -type f -delete

helm install prophecyide \
    --namespace prophecy ./* \
    --set global.customer.name=<ENTER_VALUE_HERE> 
```

## Step 3: Launching and setting up Prophecy IDE
You need to connect to EKS cluster to get the Prophecy IDE URL and login credentials. If you have chosen option of installing Prophecy IDE in an existing k8s cluster then you are already connected to k8s cluster. For Quick launch user, please run below commands on your laptop to connect to your kubernetes cluster.
```
aws eks --region <region> update-kubeconfig --name <eksclustername>
Please use the same eks cluster name which you have given in cloudformation stack. 
```

Please run below commands to get the Prophecy IDE URL and login creds
```
helm -n prophecy status prophecy

A sample output:
NAME: prophecy
LAST DEPLOYED: Wed Jun  8 11:26:55 2022
NAMESPACE: prophecy
STATUS: deployed
REVISION: 1
NOTES:
Please access your Prophecy IDE at https://prophecy.mycompanyname.cloud.prophecy.io with username _ and password _. Please change your password by going to the settings page after the first login.
```

### 1. Launch Prophecy IDE and finish Onboarding

a. **Login**: Open the prophecyURL and login using adminUser and its credentials 
![11](https://user-images.githubusercontent.com/59466885/163799857-0674e97f-a3c1-47b7-9543-7274e16da830.jpg)


b. **Onboarding**: 

Click on Setup to finish the onboarding. 
![12](https://user-images.githubusercontent.com/59466885/163799864-d0e21bd7-32fe-45ae-ac22-ba562c03f04c.jpg)

Setup Fabric to configure Prophecy IDE with your Databricks environment. 
_Note: Fabric is an execution environment. This is where you configure your spark endpoint details, spark credentials, etc._

![13](https://user-images.githubusercontent.com/59466885/163799874-3a8d559e-cd0d-454e-bcc8-f9839325a6b4.jpg)
