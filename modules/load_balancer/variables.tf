variable "common_tags" {
  type        = map(string)
  description = "(Optional) Map of common tags for all taggable AWS resources."
  default     = {}
}

variable "jenkins_sg_id" {
  type        = string
  description = "Security group ID of Jenkins cluster"
}

variable "lb_health_check_path" {
  type        = string
  description = "The endpoint to check for Jenkins's health status."
}

variable "lb_subnets" {
  type        = list(string)
  description = "Subnets where load balancer will be deployed"
}

variable "resource_name_prefix" {
  type        = string
  description = "Resource name prefix used for tagging and naming AWS resources"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where Jenkins will be deployed"
}