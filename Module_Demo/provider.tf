terraform {
  terraform {
  cloud {
    organization = "Devendra_variya"

    workspaces {
      name = "dev"
    }
  }
}
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.20.1"
    }
  }
}

provider "aws" {
  region = var.region
}