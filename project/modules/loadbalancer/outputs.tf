output "gabriel_nginx_ec2_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.gabriel_nginx_ec2.id
  
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.gabriel_nginx_sg.id
}