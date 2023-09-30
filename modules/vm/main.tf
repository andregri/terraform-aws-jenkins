data "aws_ami" "ubuntu" {
  count       = var.user_supplied_ami_id != null ? 0 : 1
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "jenkins" {
  name   = "${var.resource_name_prefix}-jenkins"
  vpc_id = var.vpc_id

  tags = merge(
    { Name = "${var.resource_name_prefix}-jenkins-sg" },
    var.common_tags,
  )
}

resource "aws_security_group_rule" "jenkins_outbound" {
  description       = "Allow Jenkins nodes to send outbound traffic"
  security_group_id = aws_security_group.jenkins.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jenkins_application_lb_inbound" {
  description              = "Allow load balancer to reach Jenkins nodes on port 8080"
  security_group_id        = aws_security_group.jenkins.id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = var.jenkins_lb_sg_id
}

resource "aws_security_group_rule" "jenkins_ssh_inbound" {
  count             = var.allowed_inbound_cidrs_ssh != null ? 1 : 0
  description       = "Allow specified CIDRs SSH access to Jenkins nodes"
  security_group_id = aws_security_group.jenkins.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_inbound_cidrs_ssh
}

resource "aws_launch_template" "jenkins" {
  name          = "${var.resource_name_prefix}-jenkins"
  image_id      = var.user_supplied_ami_id != null ? var.user_supplied_ami_id : data.aws_ami.ubuntu[0].id
  instance_type = var.instance_type
  key_name      = var.key_name != null ? var.key_name : null
  user_data     = var.userdata_script
  vpc_security_group_ids = [
    aws_security_group.jenkins.id,
  ]

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_type           = "gp3"
      volume_size           = 100
      throughput            = 150
      iops                  = 3000
      delete_on_termination = true
    }
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

resource "aws_autoscaling_group" "jenkins" {
  name                = "${var.resource_name_prefix}-jenkins"
  min_size            = var.node_count
  max_size            = var.node_count
  desired_capacity    = var.node_count
  vpc_zone_identifier = var.jenkins_subnets
  target_group_arns   = var.jenkins_target_group_arns

  launch_template {
    id      = aws_launch_template.jenkins.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.resource_name_prefix}-jenkins-server"
    propagate_at_launch = true
  }
}
