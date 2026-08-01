output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu.id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "aws_region" {
  value = data.aws_region.current.endpoint
}

output "available_azs_id" {
  value = data.aws_availability_zones.available.id
}

output "available_azs_names" {
  value = data.aws_availability_zones.available.names
}

output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}
