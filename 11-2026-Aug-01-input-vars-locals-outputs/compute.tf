data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-arm64-server-*"] # arm64 instead of amd64
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_config["size"]
    volume_type           = var.ec2_volume_config["type"]
  }

  tags = merge(
    {
      Name      = "Terraform-EC2-Instance"
      ManagedBy = "Terraform"
    },
    var.additional_tags
  )
}
