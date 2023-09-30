provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

resource "tls_private_key" "jenkins_single_node" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "jenkins_single_node" { 
  filename = "${path.module}/key.pem"
  content = tls_private_key.jenkins_single_node.private_key_pem
}

resource "aws_key_pair" "jenkins_single_node" {
  public_key = tls_private_key.jenkins_single_node.public_key_openssh
}

module "jenkins_single_node" {
  source = "../.."

  allowed_inbound_cidrs_ssh = ["0.0.0.0/0"]
  instance_type             = "t2.micro"
  key_name                  = aws_key_pair.jenkins_single_node.key_name
  lb_health_check_path      = "/login"
  node_count                = 1
  resource_name_prefix      = "example-single-node"
  vpc_id                    = data.aws_vpc.default.id
}
