aws_region        = "ap-northeast-1"
ec2_instance_type = "t4g.small"

ec2_volume_config = {
  size = "20"
  type = "gp3"
}

additional_tags = {
  ValuesFrom = "auto.tfvars"
}
