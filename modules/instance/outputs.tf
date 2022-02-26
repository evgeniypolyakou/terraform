output "server_public_ip" {
  value = module.network.aws_eip_public_ip
}
