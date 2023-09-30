output "asg_name" {
  value = module.vm.asg_name
}

output "launch_template_id" {
  value = module.vm.launch_template_id
}

output "jenkins_lb_dns_name" {
  description = "DNS name of Jenkins load balancer"
  value       = module.loadbalancer.jenkins_lb_dns_name
}

output "jenkins_lb_zone_id" {
  description = "Zone ID of Jenkins load balancer"
  value       = module.loadbalancer.jenkins_lb_zone_id
}

output "jenkins_lb_arn" {
  description = "ARN of Jenkins load balancer"
  value       = module.loadbalancer.jenkins_lb_arn
}

output "jenkins_target_group_arn" {
  description = "Target group ARN to register Jenkins nodes with"
  value       = module.loadbalancer.jenkins_target_group_arn
}

output "jenkins_sg_id" {
  description = "Security group ID of Jenkins cluster"
  value       = module.vm.jenkins_sg_id
}
