output "jenkins_userdata_base64_encoded" {
  value = base64encode(local.jenkins_user_data)
}