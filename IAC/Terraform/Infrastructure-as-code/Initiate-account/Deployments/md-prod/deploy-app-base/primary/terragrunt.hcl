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
  region_context  = "primary"
  deploy_globally = "true"
  region          = local.region_context == "primary" ? include.cloud.locals.region.primary : include.cloud.locals.region.secondary
  deployment_name = "terraform-${include.env.locals.name_abr}-deploy-app-base-${local.region_context}"

  # Composite variables 
  tags = merge(
    include.env.locals.tags,
    {
      ManagedBy = "terraform:${local.deployment_name}"
    }
  )
}


#-------------------------------------------------------
# Inputs 
#-------------------------------------------------------
inputs = {
  common = {
    global        = local.deploy_globally
    account_name  = include.cloud.locals.account_name.kah.name
    region_prefix = include.cloud.loacls.region_prefix.primary
    tags          = local.tags
  }

  vpc = {
    name = include.env.locals.environment
    cidr_block = 
  }
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
  source = "../../../..//Formation/Create-vpc"
}