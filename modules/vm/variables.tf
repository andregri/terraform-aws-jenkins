variable "allowed_inbound_cidrs_ssh" {
  type        = list(string)
  description = "List of CIDR blocks to give SSH access to Jenkins nodes"
  default     = null
}

variable "common_tags" {
  type        = map(string)
  description = "(Optional) Map of common tags for all taggable AWS resources."
  default     = {}
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "m5.xlarge"
}

variable "jenkins_lb_sg_id" {
  type        = string
  description = "Security group ID of Jenkins load balancer"
}

variable "jenkins_subnets" {
  type        = list(string)
  description = "Private subnets where Jenkins will be deployed"
}

variable "jenkins_target_group_arns" {
  type        = list(string)
  description = "Target group ARN(s) to register Jenkins nodes with"
}

variable "key_name" {
  type        = string
  description = "key pair to use for SSH access to instance"
  default     = null
}

variable "node_count" {
  type        = number
  description = "Number of Jenkins nodes to deploy in ASG"
  default     = 5
}

variable "resource_name_prefix" {
  type        = string
  description = "Resource name prefix used for tagging and naming AWS resources"
}

variable "userdata_script" {
  type        = string
  description = "Userdata script for EC2 instance"
}

variable "user_supplied_ami_id" {
  type        = string
  description = "AMI ID to use with Jenkins instances"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where Jenkins will be deployed"
}