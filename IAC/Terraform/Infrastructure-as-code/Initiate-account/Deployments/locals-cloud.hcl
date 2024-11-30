#-------------------------------------------------------
# Cloud variables 
#-------------------------------------------------------
locals {
  account_name = {
    Kah = {
      name   = "prod"
      number = "485147667400"
    }
    int = {
      name   = "integration"
      number = "730335294148"
    }
    dev = {
      name   = "development"
      number = "730335294148"
    }
    qa = {
      name   = "quality-assurance"
      number = "271457809232"
    }
  }
  billing_code_number = {
    kah = "90471"
    int = "TBD"
    dev = "TBD"
    qa  = "TBD"
  }
  region_prefix = {
    primary   = "use1"
    secondary = "usw2"
  }
  region = {
    primary   = "us-east-1"
    secondary = "us-west-2"
  }
}