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
  region_prefix = {
    primary   = "use1"
    secondary = "usw2"
  }

}