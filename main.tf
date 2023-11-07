terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28.0"
    }
  }
  }

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "My-VM" {
  ami           = "ami-00448a337adc93c05"
  instance_type = "t2.micro"
}
