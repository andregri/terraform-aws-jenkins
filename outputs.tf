output "ssh_endpoint" {
  value = <<-EOF
    Jenkins IP (public):  ${aws_instance.jenkins.public_ip}
    Jenkins IP (private): ${aws_instance.jenkins.private_ip}

    For example:
        ssh -i ${var.key_name}.pem ubuntu@${aws_instance.jenkins.public_ip}
  EOF
}
