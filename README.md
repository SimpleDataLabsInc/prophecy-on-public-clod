# prophecy-terraform
A Terraform module to setup a kubernetes cluster in public cloud for Prophecy IDE deployment. This module supports Terraform v1.x.

# Supported features
## AWS
- Setup EKS Cluster
- Setup EFS Storage
- Bind EKS and EFS using Mount Targets.
- 
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
Edit aws/eks/terraform.tfvars to give EKS cluster's input. 
<pre><code>  
customer-name  = "customername"
cluster-name   = "cluster1"
region         = "us-east-1"
</code></pre>

- customer-name : a name to uniquely identify your org
- cluster-name: a cluster name to uniquely identify Prophecy's EKS cluster
- region: aws region where you want to deploy Prophecy cluster

#### Run Terraform
<pre><code>  
terraform init
terraform plan #review the plan
terraform apply
</code></pre>

When your run the 'apply' command, be sure to review the output before typing 'yes'. This is critical in the case of using Terraform for upgrades. For an initial deployment, it usually takes 15-30 minutes. 

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
 aws eks --region <region> update-kubeconfig --name <customer-name>-<cluster-name> --alias <customer-name>-<cluster-name>
 aws eks --region us-east-1 update-kubeconfig --name customername-cluster1 --alias customername-cluster1
</code></pre>

