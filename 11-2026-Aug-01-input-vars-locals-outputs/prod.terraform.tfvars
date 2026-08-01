aws_region        = "ap-northeast-1"
ec2_instance_type = "t4g.micro"

ec2_volume_config = {
  size = "50"
  type = "gp3"
}

additional_tags = {
  Environment = "Production"
  Project     = "Terraform-EC2"
  ManagedBy   = "Terraform"
}
