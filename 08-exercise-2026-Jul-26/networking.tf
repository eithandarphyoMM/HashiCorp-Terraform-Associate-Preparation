resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name      = "08-exercise-2026-Jul-26-vpc"
    ManagedBy = "Terraform"
    Project   = "08-exercise-2026-Jul-26"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name      = "08-exercise-2026-Jul-26-public-subnet"
    ManagedBy = "Terraform"
    Project   = "08-exercise-2026-Jul-26"
  }
}
