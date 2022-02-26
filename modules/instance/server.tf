data "aws_ami" "ubuntu_20_04" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*"]
  }
}

/*
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "evgeniypolyakov"
    key    = "dev/main/terraform.tfstate"
    region = "us-east-2"
  }
}
*/
module "network" {
  source = "../network"
}

//provider "aws" {
// region = "us-east-2"
//}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.ubuntu_20_04  .id
  instance_type          = var.instance_type
  subnet_id              = module.network.private_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.aws_server.id]
  key_name               = "ssh-key"
  user_data              = file("user_data.sh")

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name     = "${var.env}-Server create by Terraform"
    Owner    = "Evgeniy Polyakov"
    UserName = "pol.iowa666@gmail.com"
  }
}

resource "aws_security_group" "aws_server" {
  vpc_id = module.network.vpc_id

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.env}-Dynamic SecurityGroup"
    Owner    = "Evgeniy Polyakov"
    UserName = "pol.iowa666@gmail.com"
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = var.ssh_public_key
}
