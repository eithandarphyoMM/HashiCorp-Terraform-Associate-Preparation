resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Project = local.project
    Name    = local.project
  }
}

# Calculated non-overlapping subnets (e.g., 10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24)
resource "aws_subnet" "main" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Project = local.project
    Name    = "${local.project}-subnet-${count.index + 1}"
  }
}

# Fetch availability zones in ap-northeast-1 dynamically
data "aws_availability_zones" "available" {
  state = "available"
}
