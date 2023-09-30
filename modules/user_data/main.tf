locals {
  jenkins_user_data = templatefile(
    var.user_supplied_userdata_path != null ? var.user_supplied_userdata_path : "${path.module}/templates/install_jenkins.sh.tpl",
    {
      region                = var.aws_region
    }
  )
}