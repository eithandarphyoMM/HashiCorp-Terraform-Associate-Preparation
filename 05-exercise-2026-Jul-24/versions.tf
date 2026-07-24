terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket       = "terraform-remote-backend-demo-20260724"
    key          = "state.tfstate"
    region       = "ap-northeast-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
