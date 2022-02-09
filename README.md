# prophecy-terraform
A Terraform module to setup a kubernetes cluster in public cloud for Prophecy IDE deployment. This module supports Terraform v1.x.

# Prerequisites
Install the necessary tools on your machine from where you going to deploy this code:
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- [Terraform](https://www.terraform.io/downloads.html?_ga=2.200237742.12622995.1644315917-895589725.1644315917) Use version 0.13.5 or later
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) Use the version appropriate for your Kubernetes cluster version

# Supported features
## AWS
- Setup EKS Cluster
- Setup EFS Storage
- Bind EKS and EFS using Mount Targets.

# Installation
## AWS
