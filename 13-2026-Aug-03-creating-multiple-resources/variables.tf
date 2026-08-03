locals {
  project = "my-aws-project"
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}

variable "aws_subnet" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = [
    {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "ap-northeast-1a"
    },
    {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "ap-northeast-1b"
    },
    {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "ap-northeast-1c"
    }
  ]
}
