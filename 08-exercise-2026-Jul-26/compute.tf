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

  tags = merge(local.common_tags, {
    Name = "08-exercise-2026-Jul-26-web-instance"
  })
}
