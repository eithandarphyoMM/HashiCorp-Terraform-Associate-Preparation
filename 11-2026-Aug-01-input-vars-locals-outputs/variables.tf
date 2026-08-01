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

variable "ec2_volume_size" {
  type        = number
  description = "EC2 volume size"
  default     = 10
}

variable "ec2_volume_type" {
  type        = string
  description = "EC2 volume type"
  default     = "gp3"
}
