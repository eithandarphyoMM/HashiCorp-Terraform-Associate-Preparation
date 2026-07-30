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

output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}
