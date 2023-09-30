output "jenkins_lb_dns_name" {
  description = "DNS name of Jenkins load balancer"
  value       = module.jenkins_single_node.jenkins_lb_dns_name
}