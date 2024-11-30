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