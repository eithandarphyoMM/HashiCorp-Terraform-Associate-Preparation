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
        condition     = startswith(var.ec2_instance_type, "t4g") //Free Tier eligible instance types
        error_message = "Only support t4g family"
    }
}

variable "ec2_volume_config" {
    type        = map(string)
    description = "The size and type of the root block volume for the EC2 instance"

    default     = {
        size = 10
        type = "gp3"
    }
}

variable "additional_tags" {
    type        = map(string)
    description = "Additional tags to apply to resources"
    default     = {}
}
