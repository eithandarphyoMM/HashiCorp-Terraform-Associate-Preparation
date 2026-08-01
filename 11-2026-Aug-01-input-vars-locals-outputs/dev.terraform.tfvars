# Fixed variable name: changed "region" to "aws_region"
aws_region = "ap-southeast-1"

# Fixed instance type: "t4g.small" fails validation, changed to an allowed type (e.g., "t4g.micro")
ec2_instance_type = "t4g.micro"

# Valid map matching var.ec2_volume_config
ec2_volume_config = {
  size = "20"
  type = "gp2"
}

# Optional: Add bucket_name ONLY if declared in variables.tf
# bucket_name = "my-public-read-bucket"
