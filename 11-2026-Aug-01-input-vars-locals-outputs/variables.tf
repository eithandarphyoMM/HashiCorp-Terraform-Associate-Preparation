variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "ap-northeast-1"
}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t3.small", "t4g.micro"], var.ec2_instance_type) //Free Tier eligible instance types
    error_message = "Invalid EC2 instance type. Allowed values are: t3.micro, t3.small, t4g.micro."
  }
}

variable "ec2_volume_config" {
  type        = map(string)
  description = "The size and type of the root block volume for the EC2 instance"

  default = {
    size = 10
    type = "gp3"
  }
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to apply to resources"
  default     = {}
}
