variable "subnet_count" {
  type        = number
  default     = 3
  description = "Number of subnets to create in ap-northeast-1"
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["t3.micro"], config.instance_type)
    ])
    error_message = "Only t3.micro instances are allowed for Free Tier in ap-northeast-1."
  }

  validation {
    condition = alltrue([
      for config in values(var.ec2_instance_config_map) : contains(["nginx", "ubuntu"], config.ami)
    ])
    error_message = "At least one of the provided \"ami\" values is not supported.\nSupported \"ami\" values: \"ubuntu\", \"nginx\"."
  }
}
