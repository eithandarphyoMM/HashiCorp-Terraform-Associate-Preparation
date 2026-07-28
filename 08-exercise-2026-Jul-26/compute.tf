# Fetch the latest x86_64 Amazon Linux 2023 AMI ID dynamically
data "aws_ssm_parameter" "al2023_x86" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "web" {
  ami                         = data.aws_ssm_parameter.al2023_x86.value
  associate_public_ip_address = true
  instance_type               = "t3.micro"

  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp2"
  }

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.public_http_traffic.id]

  tags = merge(local.common_tags, {
    Name = "08-exercise-2026-Jul-26-web-instance"
  })
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
