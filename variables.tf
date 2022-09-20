variable "key_name" {
  description = "Name of the AWS key pair to SSH into the EC2 instance"
  type        = string
}

variable "environment_name" {
  type = string
}

variable "region" {
  type = string
}

variable "availability_zones" {
  type = string
}
