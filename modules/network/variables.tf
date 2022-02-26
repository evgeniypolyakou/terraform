variable "env" {
  default = "dev"
}
variable "main_vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "private_subnets_cidrs" {
  default = [
    "10.0.10.0/24",
    "10.0.20.0/24",
  ]
}
