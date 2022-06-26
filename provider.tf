terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.61.0"
    }
  }
}
provider "aws" {
  region  = "ap-south-1"
  version = "3.61.0"
}