terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "ap-northeast-1"
}

provider "aws" {
  region = "ap-southeast-1"
  alias  = "ap-southeast-1"
}

resource "aws_s3_bucket" "ap_northeast_1" {
  bucket   = "some-random-bucket-name-afsaojfosajfosahfpo20260725"
  provider = aws.ap-northeast-1
}

resource "aws_s3_bucket" "ap_southeast_1" {
  bucket   = "some-random-bucket-name-jlfdnfksafksadksa"
  provider = aws.ap-southeast-1
}
