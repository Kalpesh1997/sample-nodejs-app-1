terraform {
  required_version = ">=0.12"
  backend "s3" {
    bucket = "sample-nodejs-app-1-bucket"
    key = "sample-nodejs-app-1/state.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.33.0"
    }
  }
}

provider "aws" {
  # Configuration option
  region = us-east-1
}

data "aws_ami" "latest_amazon_linux_image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name" 
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "app_server_1" {
  ami = data.aws_ami.latest_amazon_linux_image
  instance_type = "t2.micro"

  subnet_id = "subnet-0aed09be51c196cdc"
  vpc_security_group_ids = [ "sg-0b8a7d86475c8bcbd" ]
  availability_zone = "us-east-1a"

  associate_public_ip_address = true
  key_name = "sample-nodejs-app-key"

  tags = {
    "Name" = "prod-app_server_1"
  }
}

resource "aws_instance" "app_server_2" {
  ami = data.aws_ami.latest_amazon_linux_image
  instance_type = "t2.micro"

  subnet_id = "subnet-00569cd89b72a9b7d"
  vpc_security_group_ids = [ "sg-0b8a7d86475c8bcbd" ]
  availability_zone = "us-east-1b"

  associate_public_ip_address = true
  key_name = "sample-nodejs-app-key"
  
  tags = {
    "Name" = "prod-app_server_2"
  }
}