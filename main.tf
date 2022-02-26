terraform {
  backend "s3" {
    bucket = "evgeniypolyakov"
    key    = "dev/main/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
    region = "us-east-2"
}

module "network" {
    source = "./modules/network"
}

module "instance" {
    source = "./modules/instance"
}