terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28.0"
    }
     hcp = {
      source = "hashicorp/hcp"
      version = "0.76.0"
    }
  }
  }

provider "aws" {
  region                = "us-west-2"
  AWS_ACCESS_KEY_ID     = data.hcp_vault_secrets_secret.access_key.secret_value
  AWS_SECRET_ACCESS_KEY = data.hcp_vault_secrets_secret.secret_key.secret_value
}

data "hcp_vault_secrets_secret" "access_key" {
  app_name    = "Learning-app"
  secret_name = "AWS_ACCESS_KEY_ID"
}

data "hcp_vault_secrets_secret" "secret_key" {
  app_name    = "Learning-app"
  secret_name = "AWS_SECRET_ACCESS_KEY"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}
