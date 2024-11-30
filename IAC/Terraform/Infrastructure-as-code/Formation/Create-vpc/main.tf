#--------------------------------------------------------------------
# VPC - Creates a VPC  to the target account
#--------------------------------------------------------------------
module "vpc" {
  source = "git@github.com:njibrigthain100/Cognitech-terraform-iac-modules.git/terraform/modules/vpc?ref=v1.1"
  for_each = var.vpc != null ? { for item in var.vpc : item.key => item } : {} 
    
  common = var.common
  vpc = each.value 
}