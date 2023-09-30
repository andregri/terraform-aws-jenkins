output "asg_name" {
  description = "Name of autoscaling group"
  value       = aws_autoscaling_group.jenkins.name
}

output "launch_template_id" {
  description = "ID of launch template for Jenkins autoscaling group"
  value       = aws_launch_template.jenkins.id
}

output "jenkins_sg_id" {
  description = "Security group ID of Jenkins cluster"
  value       = aws_security_group.jenkins.id
}