data "aws_region" "current" {}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

module "loadbalancer" {
  source = "./modules/load_balancer"

  common_tags          = var.common_tags
  jenkins_sg_id        = module.vm.jenkins_sg_id
  lb_health_check_path = var.lb_health_check_path
  lb_subnets           = data.aws_subnets.default.ids
  resource_name_prefix = var.resource_name_prefix
  vpc_id               = var.vpc_id
}

module "user_data" {
  source = "./modules/user_data"

  aws_region = data.aws_region.current.id
}

module "vm" {
  source = "./modules/vm"

  allowed_inbound_cidrs_ssh = var.allowed_inbound_cidrs_ssh
  common_tags               = var.common_tags
  instance_type             = var.instance_type
  jenkins_lb_sg_id          = module.loadbalancer.jenkins_lb_sg_id
  jenkins_target_group_arns = [module.loadbalancer.jenkins_target_group_arn]
  jenkins_subnets           = data.aws_subnets.default.ids
  key_name                  = var.key_name
  node_count                = var.node_count
  resource_name_prefix      = var.resource_name_prefix
  userdata_script           = module.user_data.jenkins_userdata_base64_encoded
  user_supplied_ami_id      = var.user_supplied_ami_id
  vpc_id                    = var.vpc_id
}
