terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}

locals {
  aws_region = "us-east-1"
}

provider "aws" {
  # Configuration options
  region = local.aws_region
}

module "jenkins" {
  source             = "../../"
  key_name           = "kp"
  environment_name   = "dev"
  region             = local.aws_region
  availability_zones = join("", [local.aws_region, "a"])
}
