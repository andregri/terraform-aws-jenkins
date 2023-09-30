resource "aws_security_group" "jenkins_lb" {
  description = "Security group for the application load balancer"
  name        = "${var.resource_name_prefix}-jenkins-lb-sg"
  vpc_id      = var.vpc_id

  tags = merge(
    { Name = "${var.resource_name_prefix}-jenkins-lb-sg" },
    var.common_tags,
  )
}

resource "aws_security_group_rule" "jenkins_lb_inbound" {
  description       = "Allow access to load balancer on port 8080"
  security_group_id = aws_security_group.jenkins_lb.id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jenkins_lb_outbound" {
  description              = "Allow outbound traffic from load balancer to Jenkins nodes on port 8080"
  security_group_id        = aws_security_group.jenkins_lb.id
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.jenkins_sg_id
}

resource "aws_lb" "jenkins_lb" {
  name                       = "${var.resource_name_prefix}-jenkins-lb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = var.lb_subnets
  security_groups            = [aws_security_group.jenkins_lb.id]
  drop_invalid_header_fields = true

  tags = merge(
    { Name = "${var.resource_name_prefix}-jenkins-lb" },
    var.common_tags,
  )
}

resource "aws_lb_target_group" "jenkins" {
  name        = "${var.resource_name_prefix}-jenkins-tg"
  target_type = "instance"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    protocol            = "HTTP"
    port                = "traffic-port"
    path                = var.lb_health_check_path
    interval            = 30
  }

  tags = merge(
    { Name = "${var.resource_name_prefix}-jenkins-tg" },
    var.common_tags,
  )
}

resource "aws_lb_listener" "jenkins" {
  load_balancer_arn = aws_lb.jenkins_lb.id
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins.arn
  }
}
