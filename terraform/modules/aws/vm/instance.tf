
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

locals {
  image  = data.aws_ami.ubuntu.id
  subnet = var.public_subnet_ids[0]
}

resource "aws_instance" "vm" {
  ami           = local.image
  instance_type = "t2.micro"
  subnet_id     = local.subnet
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.vm_firewall.id]

  tags = {
    Name = "vm-instance"
  }
}
