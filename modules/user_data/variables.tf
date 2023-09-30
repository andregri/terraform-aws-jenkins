variable "aws_region" {
  type        = string
  description = "AWS region where Vault is being deployed"
}

variable "user_supplied_userdata_path" {
  type        = string
  description = "File path to custom userdata script being supplied by the user"
  default     = null
}