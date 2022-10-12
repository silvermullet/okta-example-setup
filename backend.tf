terraform {
  backend "remote" {
    organization = "silvermullet-okat-demo"

    workspaces {
      name = "okta-example-setup"
    }
  }

  required_version = ">= 0.14.0"
}
