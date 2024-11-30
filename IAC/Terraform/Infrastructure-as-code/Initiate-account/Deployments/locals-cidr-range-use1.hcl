locals {
  cidr_blocks = {
    mdp = {
      segments = {
        shared_services = {
          vpc = "10.1.2.0/24"
          subnets = {
            public = {
              primary   = "10.1.2.64/27"
              secondary = "10.1.2.96/27"
            }
            private = {
              primary   = "10.1.2.0/27"
              secondary = "10.1.2.96/27"
            }
          }
        }
        sit = {
          vpc = "10.1.1.0/24"
          subnets = {
            public = {
              primary   = "10.1.1.64/27"
              secondary = "10.1.1.96/27"
            }
            private = {
              primary   = "10.1.1.0/27"
              secondary = "10.1.1.32/27"
            }
          }
        }
        trn = {
          vpc = "10.1.3.0/24"
          subnets = {
            public = {
              primary   = "10.1.3.64/27"
              secondary = "10.1.3.96/27"
            }
            private = {
              primary   = "10.1.3.0/27"
              secondary = "10.1.3.32/27"
            }
          }
        }
        trn = {
          vpc = "10.1.4.0/24"
          subnets = {
            public = {
              primary   = "10.1.4.64/27"
              secondary = "10.1.4.96/27"
            }
            private = {
              primary   = "10.1.4.0/27"
              secondary = "10.1.4.32/27"
            }
          }
        }
      }
    }
  }
}