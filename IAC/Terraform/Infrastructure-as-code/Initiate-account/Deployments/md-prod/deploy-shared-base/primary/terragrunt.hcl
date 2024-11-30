#-------------------------------------------------------
# Includes Block 
#-------------------------------------------------------

include "cloud" {
  path   = find_in_parent_folders("locals-cloud.hcl")
  expose = true
}

include "env" {
  path   = find_in_parent_folders("locals-env.hcl")
  expose = true
}

#-------------------------------------------------------
# Locals 
#-------------------------------------------------------
locals {
  region_context = "primary"
  region = local.region_context == "primary" ? include.cloud.locals.region.primary : include.cloud.locals.region.secondary
  deployment_name = "terraform-${include.}"

  # Composite variables 
  tags = merge(
    include.env.locals.tags,
    {
      ManagedBy = "terraform"
    }
  )
}

















#-------------------------------------------------------
# Providers 
#-------------------------------------------------------
generate "aws-providers" {
  path      = "aws-provider.tf"
  if_exists = "overwite"
  contents  = <<-EOF
  provider "aws" {
    region = "${local.region}"
  }
  EOF
}



#-------------------------------------------------------
# Source  
#-------------------------------------------------------
terraform {
    source = "../../..//Formation/Create-vpc"
}