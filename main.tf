resource "aws_instance" "jenkins" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = module.vault_demo_vpc.public_subnets[0]
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.environment_name}-jenkins"
  }

  user_data = templatefile("${path.module}/templates/userdata-jenkins.tpl",
    {
      tpl_aws_region = var.region
  })

  lifecycle {
    ignore_changes = [
      ami,
      tags,
    ]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
