# Terraform_Kubernetes

# Introduction

## Scope

## Intended Audience

## Warnings
open ssh - security group
s3 bucket is not encrypted, 
ec2 image is not hardened, 
include AWS best security practices guide

# List of Equipment and Materials

## Outside of the Scope of This Manual

AWS User, AWS Account
Requires AWS Role (for use by EC2) w/ the Following Permissions -----> ec2FullAccess, IAMFullAccess, S3FullAccess, VPCFullAccess, Route53FullAccess
Configured Route 53 Hosted Zone

# Directions

## Install the Latest Updates
sudo apt update -y && sudo apt upgrade -y

## Install Terraform
Consult the [Terraform Installation Documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli). Download the Terraform CLI for your appropriate operating system (OS). 

## Configure the Amazon Web Services (AWS) Command-Line (CLI)

### Install the AWS CLI
Consult the [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html). Download the AWS CLI for your appropriate operating system (OS).

### Configure the AWS CLI
Consult the [AWS CLI Configuration Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html). Warning: You will need an AWS Access ID and Secret Key, which may be otained through the AWS IAM dashboard (via Users, Selected User, Security Credentials).  

## Deploy Terraform Infrastructure

### Download the Repository

### Initialize Terraform
terraform init

### Apply the Template
terraform kube.tf -auto-approve

### View the Created Resources
Refer to Proof of Concept (POC) directory to view screen captures of provisioned infrastructure. 
