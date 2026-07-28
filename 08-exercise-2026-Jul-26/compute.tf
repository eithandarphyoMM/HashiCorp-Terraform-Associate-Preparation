# Fetch the latest x86_64 Ubuntu 24.04 LTS AMI dynamically via SSM
data "aws_ssm_parameter" "ubuntu_2404_x86" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

resource "aws_instance" "web" {
  user_data = <<-EOF
            #!/bin/bash
            apt-get update -y
            apt-get install -y nginx
            systemctl enable nginx
            systemctl start nginx
            EOF

  ami                         = data.aws_ssm_parameter.ubuntu_2404_x86.value
  instance_type               = "t3.micro"
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp3"
  }

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.public_http_traffic.id]

  tags = merge(local.common_tags, {
    Name = "08-exercise-2026-Jul-26-Ubuntu-WebServer"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "public_http_traffic" {
  name        = "08-exercise-2026-Jul-26-public-http-traffic"
  description = "Security group allowing traffic on ports 443 and 80"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

