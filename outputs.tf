output "public_ip_ec2" {
  description = "Public IP address of the EC2 instance"
  value       = module.network.aws_eip_public_ip
}