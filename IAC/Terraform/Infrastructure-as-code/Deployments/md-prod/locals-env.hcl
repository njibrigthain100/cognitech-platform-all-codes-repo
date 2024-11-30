locals {
  cloud = read_terragrunt_config(find_in_parent_folders(locals-cloud.hcl))

  account_name   = local.cloud.locals.account_name.kah.name
  account_number = local.cloud.locals.account_name.kah.number
  billing_code   = local.cloud.locals.billing_code_number.kah
}