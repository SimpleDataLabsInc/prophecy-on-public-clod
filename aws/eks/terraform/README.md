A Terraform module to setup a kubernetes cluster in public cloud for Prophecy IDE deployment. This module supports Terraform v1.x.

# Supported features
## AWS
- Setup EKS Cluster
- Setup EFS Storage
- Bind EKS and EFS using Mount Targets.

# Prerequisites
## Tools
Install the necessary tools on your machine from where you going to deploy this code:
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- [Terraform](https://www.terraform.io/downloads.html?_ga=2.200237742.12622995.1644315917-895589725.1644315917) Use version 0.13.5 or later
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) Use the version appropriate for your Kubernetes cluster version

## Configure the AWS CLI
Run the following command and enter the appropriate values when prompted. If you don't know the AWS Access Key ID or AWS Secret Access Key for your account, contact your AWS admin.

<pre><code> aws configure </code></pre>

Confirm you are authenticated

<pre><code> aws sts get-caller-identity </code></pre>

# Installation
## AWS
### EKS
Edit aws/eks/terraform.tfvars to give EKS cluster's input. The idea is to create a EKS cluster with the below variables and support for provisioning EBS volumes for Kubernetes PVCs.
<pre><code>
customer_name   = "customername"
cluster_name    = "cluster1"
cluster_version = "1.24"
instance_class  = "t3.2xlarge"
region          = "us-east-1"
</code></pre>

- customer-name : a name to uniquely identify your org.
- cluster-name: a cluster name to uniquely identify Prophecy's EKS cluster.
- cluster_version: Kubernetes version of the cluster. We are going with the default version of `1.24`. However, if you face issues with creating EBS volumes using this version please recreate a cluster with version `1.21` (as it uses in-tree volume provisioner).
- instance_class: Is the type of EC2 instance required. Please use the suggested version here to avoid over/under provisioning.
- region: aws region where you want to deploy Prophecy cluster.

#### Run Terraform
<pre><code>
terraform init
terraform plan #review the plan
terraform apply
</code></pre>

When your run the 'apply' command, be sure to review the output before typing 'yes'. This is critical in the case of using Terraform for upgrades. For an initial deployment, it usually takes 15-30 minutes.

Once terraform run is succcessful, you can use the below command to download the KUBECONFIG for your newly created cluster.
```
aws eks --region <us-east-1> update-kubeconfig --name <customername-prophecycluster> --alias <customername-prophecycluster>
```
### EFS
Edit aws/efs/terraform.tfvars to give EFS related input.
<pre><code>
customer-name  = "customername"
efs-name       = "efs-cluster1"
region         = "us-east-1"
</code></pre>

- customer-name : same as aws/eks/terraform.tfvars
- efs-name: a efs name to uniquely identify Prophecy's EFS
- region: same as aws/eks/terraform.tfvars

#### Run Terraform
<pre><code>
terraform init
terraform plan #review the plan
terraform apply
</code></pre>

When your run the 'apply' command, be sure to review the output before typing 'yes'. This is critical in the case of using Terraform for upgrades. For an initial deployment, it usually takes 5-10 minutes. 

### EFS Mount Target
Edit aws/efsmounttarget/terraform.tfvars to give EFS Mount Target related inputs. 
<pre><code>
customer-name  = "customername"
cluster-name   = "customername_cluster1"
region         = "us-east-1"
</code></pre>

- customer-name : same as aws/eks/terraform.tfvars
- cluster-name: same as aws/eks/terraform.tfvars
- region: same as aws/eks/terraform.tfvars

#### Run Terraform
<pre><code>
terraform init
terraform plan #review the plan
terraform apply
</code></pre>

When your run the 'apply' command, be sure to review the output before typing 'yes'. This is critical in the case of using Terraform for upgrades. For an initial deployment, it usually takes 5-10 minutes.

# Kubeconfig
To get kubeconfig of cluster, please run below command:
<pre><code>
 aws eks --region {$region} update-kubeconfig --name {$customer-name}-{$cluster-name} --alias {$customer-name}-{$cluster-name}

 e.g. for above inputs : aws eks --region us-east-1 update-kubeconfig --name customername-cluster1 --alias customername-cluster1
</code></pre>

