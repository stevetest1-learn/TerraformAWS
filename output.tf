output "instance_id" {
  value       = aws_instance.app_server.id
  description = "ID if the EC2 Instance"
  
}

output "instance_public_id" {
  value       = aws_instance.app_server.public_ip
  description = "Public IP "
}
