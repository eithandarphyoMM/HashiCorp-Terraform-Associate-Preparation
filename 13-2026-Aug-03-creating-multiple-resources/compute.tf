# ------------------------------------------------------------------------------
# 1. DATA SOURCES
# ------------------------------------------------------------------------------
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ------------------------------------------------------------------------------
# 2. LOCALS
# ------------------------------------------------------------------------------
locals {
  project = "my-aws-project"

  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
    nginx  = data.aws_ami.ubuntu.id
  }
}

# ------------------------------------------------------------------------------
# 3. COMPUTE RESOURCES
# ------------------------------------------------------------------------------
resource "aws_instance" "from_map" {
  for_each = var.ec2_instance_config_map

  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type

  subnet_id = aws_subnet.main[
    index(keys(var.ec2_instance_config_map), each.key) % length(aws_subnet.main)
  ].id

  # Cleaned user_data condition: EOF is on its own line
  user_data = each.value.ami == "nginx" ? (<<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl enable --now nginx
  EOF
  ) : null

  tags = {
    Name    = "${local.project}-${each.key}"
    Project = local.project
    Subnet  = each.value.subnet_name
  }
}
