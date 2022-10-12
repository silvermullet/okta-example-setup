terraform {
  backend "remote" {
    organization = "silvermullet-okat-demo"

    workspaces {
      name = "okta-example-setup"
    }
  }

  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 3.37"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 0.14.0"
}
