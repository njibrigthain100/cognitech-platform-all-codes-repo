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
  region_context   = "primary"
  deploy_globally  = "true"
  region           = local.region_context == "primary" ? include.cloud.locals.region.primary : include.cloud.locals.region.secondary
  deployment_name  = "terraform-${include.env.locals.name_abr}-deploy-app-base-${local.region_context}"
  cidr_blocks      = local.region_context == "primary" ? include.cloud.locals.cidr_block_use1 : include.cloud.locals.cidr_block_usw2
  state_bucket     = local.region_context == "primary" ? include.env.locals.remote_state_bucket.primary : include.env.locals.remote_state_bucket.secondary
  state_lock_table = include.env.locals.remote_dynamodb_table

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
    account_name  = include.cloud.locals.account_name.Kah.name
    region_prefix = include.cloud.locals.region_prefix.primary
    tags          = local.tags
  }

  vpc = {
    name       = include.env.locals.environment
    cidr_block = local.cidr_blocks[include.env.locals.name_abr].segments.sit.vpc
  }
}







#-------------------------------------------------------
# State Configuration
#-------------------------------------------------------
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket               = local.state_bucket
    bucket_sse_algorithm = "AES256"
    dynamodb_table       = local.state_lock_table
    encrypt              = true
    key                  = "${local.deployment_name}/terraform.tfstate"
    region               = local.region
  }
}







#-------------------------------------------------------
# Providers 
#-------------------------------------------------------
generate "aws-providers" {
  path      = "aws-provider.tf"
  if_exists = "overwrite"
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