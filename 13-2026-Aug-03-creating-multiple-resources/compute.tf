# 1. Fetch latest Ubuntu AMI
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

# 2. Fetch latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["137112412989"] # Amazon

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 3. Define locals (including nginx mapping)
locals {
  project = "my-aws-project"

  ami_ids = {
    ubuntu       = data.aws_ami.ubuntu.id
    amazon_linux = data.aws_ami.amazon_linux.id
    nginx        = data.aws_ami.ubuntu.id
  }
}

# 4. Create instances from LIST
resource "aws_instance" "from_list" {
  count         = length(var.ec2_instance_config_list)
  ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
  instance_type = var.ec2_instance_config_list[count.index].instance_type
  subnet_id     = aws_subnet.main[var.ec2_instance_config_list[count.index].subnet_name].id

  user_data = var.ec2_instance_config_list[count.index].ami == "nginx" ? (<<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl enable --now nginx
  EOF
  ) : null

  tags = {
    Name    = "${local.project}-list-${count.index}"
    Project = local.project
  }
}

# 5. Create instances from MAP
resource "aws_instance" "from_map" {
  for_each      = var.ec2_instance_config_map
  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.main[each.value.subnet_name].id

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
  }
}
