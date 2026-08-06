subnet_count = 3

ec2_instance_config_map = {
  web = {
    instance_type = "t3.micro"
    ami           = "nginx"
    subnet_name   = "public-1"
  }
  api = {
    instance_type = "t3.micro"
    ami           = "ubuntu"
    subnet_name   = "public-2"
  }
  worker = {
    instance_type = "t3.micro"
    ami           = "ubuntu"
    # subnet_name will automatically fall back to "default" if omitted
  }
}
