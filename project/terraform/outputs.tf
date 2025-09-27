output "ansible_public_ip" {
  value = aws_instance.ansible.public_ip
}

output "app_private_ips" {
  value = [aws_instance.app1.private_ip, aws_instance.app2.private_ip]
}

output "elb_dns_name" {
  value = aws_elb.app_elb.dns_name
}
