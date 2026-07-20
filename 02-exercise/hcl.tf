# Start by declaring your required providers. 
# This block tells Terraform where to fetch the provider.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-1"
}

/* have 2 elements, 1st is the type of resource, 2nd is the name of the resource
1st element →　aws_vpc → type of resource
2nd element →  example → name of the resource
cidr_block  →　this is argument based on the resource type「"aws_vpc"」
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
} */

# Define a resource block for an AWS S3 bucket that you want to manage with this Terraform script. The bucket argument is set to a variable which we will define later.
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# Define a data block for an AWS S3 bucket that is managed outside of this Terraform script. This allows us to fetch and use data about this external bucket.
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not-managed-by-us"
}

# Define a bucket_name variable. This is used in the resource block to set the bucket argument.
variable "bucket_name" {
  type        = string
  description = "My variable used to set bucket name"
  default     = "my_default_bucket_name"
}

# Define an output block to output the ID of the bucket that we are managing with this Terraform script.
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

# Define a local block to create a local variable. This variable is only available within this Terraform project.
locals {
  local_example = "This is a local variable"
}

# Lastly, use a module block to include a module that is located in the ./module-example directory.
module "my_module" {
  source = "./module-example"
}