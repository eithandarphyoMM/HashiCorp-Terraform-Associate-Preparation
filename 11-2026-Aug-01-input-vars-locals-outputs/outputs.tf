output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu.id
}

output "ec2_instance_type" {
  value = var.ec2_instance_type
}

output "ec2_volume_size" {
  value = var.ec2_volume_config["size"]
}

output "ec2_volume_type" {
  value = var.ec2_volume_config["type"]
}
