terraform {
  required_version = ">= 1.15.0, <2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.56.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
