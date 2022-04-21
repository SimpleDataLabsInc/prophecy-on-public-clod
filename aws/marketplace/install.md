This document provides the steps for installing the Prophecy IDE from the AWS marketplace. 
Please contact us at support@prophecy.io with any questions and we'd be happy to help!

## Step 1. Create an IAM policy

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

## Step 2. Create an IAM role with the appropriate trust relationships
We recommend doing this via eksctl. More detail and how to set up the appropriate trust relationships is available [here](https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html).
```
kubectl create namespace prophecy
            
eksctl create iamserviceaccount \
    --name prophecy \
    --namespace prophecy \
    --cluster <ENTER_YOUR_CLUSTER_NAME_HERE> \
    --attach-policy-arn IAM_policy_ARN \
    --approve \
    --override-existing-serviceaccounts
```

## Step 3. Deploy Prophecy with attached IAM role

Please run below command to deploy Prophecy to your EKS cluster.

```
export HELM_EXPERIMENTAL_OCI=1

aws ecr get-login-password \
    --region us-east-1 | helm registry login \
    --username AWS \
    --password-stdin 709825985650.dkr.ecr.us-east-1.amazonaws.com

mkdir awsmp-chart && cd awsmp-chart

helm pull oci://709825985650.dkr.ecr.us-east-1.amazonaws.com/prophecy/prophecy-marketplace --version 0.1.3

tar xf $(pwd)/* && find $(pwd) -maxdepth 1 -type f -delete

helm install prophecyide \
    --namespace prophecy ./* \
    --set customer.name=<ENTER_VALUE_HERE> 
```
