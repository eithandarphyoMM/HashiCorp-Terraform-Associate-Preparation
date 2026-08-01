# TF_VAR_instance_type = "t3.micro"
# terraform.tfvars = "t3.small"
# prod.auto.tfvars = "t3.large"
# -var and -var-file cli arguments, latest taking higher precedence = "t3.xlarge"

aws_region = "ap-southeast-1"
ec2_instance_type = "t4g.micro"
ec2_volume_config = {
  size = "20"
  type = "gp2"
}
