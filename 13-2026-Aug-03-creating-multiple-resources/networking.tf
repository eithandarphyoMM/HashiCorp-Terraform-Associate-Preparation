resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Project = local.project
    Name    = local.project
  }
}

# Fetch availability zones dynamically to ensure compatibility with your AWS account
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "main" {
  for_each = var.subnet_config

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr_block

  # Assigns active AZs dynamically per account
  availability_zone = data.aws_availability_zones.available.names[
    index(keys(var.subnet_config), each.key) % length(data.aws_availability_zones.available.names)
  ]

  tags = {
    Project = local.project
    Name    = "${local.project}-${each.key}"
  }
}
