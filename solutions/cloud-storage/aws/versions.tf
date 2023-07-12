terraform {
  required_version = "1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0,< 6.0"
    }
  }
}