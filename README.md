# Terraform Module for Terraform Cloud 
This is a Terraform Module for TFC Dog WebApp running on a Apache Server (EC2 Instance) in AWS.
All you need is then to configure your variables in your Terraform Cloud workspace. 
- prefix 
- region 
- AMI (Packer Image) 


There are two ways of provisioning an EC2 instance in AWS. You can add a provisioner within your Terraform Config or you create an "immutable Image" which can be reused in your Infrastructure Deployment Prcoess (CI/CD Pipeline).

#Packer Image
Create your Packer Image (AMI) which creates an Apache Server within a Linux Instance on Amazon 
https://github.com/lomar92/packer_WebApp

