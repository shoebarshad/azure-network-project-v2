# Azure Network Project

Deploys Azure networking infrastructure using Terraform.

## Resources
- Resource Group
- Virtual Network
- Subnet
- Network Security Group
- Public IP
- Network Interface
- Linux VM

## How to Deploy
terraform init
terraform plan
terraform apply

## How to Connect
ssh -i ~/.ssh/azure_vm_key adminuser@<public_ip>

## How to Destroy
terraform destroy