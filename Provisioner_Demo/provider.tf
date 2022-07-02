terraform {
  cloud {
    organization = "Devendra_variya"

    workspaces {
      name = "stag"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.21.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
