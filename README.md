# naveen_sample_application_deployment

Details Related to Repo:

Repo Name: naveen_sample_application_deployment

AWS REGION TO USE: eu-central-1

Language: Terraform (HCL)

This repo has the code to create required infrastructure to deploy any webapplication (i.e., MediaWiki)

Below are the Resource will get created.,
1. Network Layer - VPC, Subnet, Routes, IGW, NAT Gatway, IAM Role to publish VPC Flow Log
2. EC2 instance will be created in Public Subnet

Jenkins Setup Details:
1. Deploy jenkins in ap-south-1 and Attach IAM Role with "Administrator Access for Experiment only"
2. Terraform, Ansible, Boto3 need to be installed in Jenkins Server
3. Create a Pipeline Job with the "JenkinsFile - Jenkinsfil" in this folder

PRE-REQUISITE:
Below are the list of items required to execute Application Deployment.,
1. Create Keypair for EC2 instance in AWS Console with name "application"
2. Download and Store the privatekey in Jenkins Server location "/tmp/application.pem"
3. Once the Infrastructure creating completed "Manually Execute peering between Jenkins VPC and Newly Created Application VPC" 
HOW TO USE REPO:
To deploy resource we can directly execute "terraform commands" to deploy infrastructure


Stages in Jenkins Pipeline:
1. Download Dependency Repo
2. Application Infra Creation

Note:
This Repository is depens on the "Terraform core module repository" as shown below and this repo will be download as part of Jenkins pipeline execution
Ansibel "Host" inventory will be handle using Dynamic Inventory 

Dependency Repo: naveen_aws_core_module




