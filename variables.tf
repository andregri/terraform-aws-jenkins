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

variable "key_name" {
  type        = string
  description = "key pair to use for SSH access to instance"
  default     = null
}

variable "lb_health_check_path" {
  type        = string
  description = "The endpoint to check for Jenkins's health status."
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

variable "user_supplied_ami_id" {
  type        = string
  description = "AMI ID to use with Jenkins instances"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where Jenkins will be deployed"
}