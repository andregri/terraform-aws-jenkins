output "jenkins_lb_arn" {
  description = "ARN of jenkins load balancer"
  value       = aws_lb.jenkins_lb.arn
}

output "jenkins_lb_dns_name" {
  description = "DNS name of jenkins load balancer"
  value       = aws_lb.jenkins_lb.dns_name
}

output "jenkins_lb_sg_id" {
  description = "Security group ID of jenkins load balancer"
  value       = aws_security_group.jenkins_lb.id
}

output "jenkins_lb_zone_id" {
  description = "Zone ID of jenkins load balancer"
  value       = aws_lb.jenkins_lb.zone_id
}

output "jenkins_target_group_arn" {
  description = "Target group ARN to register jenkins nodes with"
  value       = aws_lb_target_group.jenkins.arn
}