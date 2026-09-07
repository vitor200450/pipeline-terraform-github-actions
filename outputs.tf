output "ec2_aws_ip" {
  description = "IP da instância EC2 criada na AWS"
  value       = aws_instance.ec2.public_ip
}
