# terraform block

terraform {
    required_version = "~> 1.4"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 6.0"
        }
    }

    backend "s3" {
        bucket = "my-terraform-bucket"
        key = "path/to/terraform.tfstate"
        region = "us-west-2"
    }
}

# provider block

provider "aws" {
    region = "us-west-2"
}

# data block

data "aws_vpc" "required_vpc" {
    id = "vpc-0123456789abcdef0"
}

# variable block

variable "instance_details" {
    type = object({
        name = string
        size = number
        ip_address = bool
    })
    default = {
        name = "web_server"
        size = 20
        ip_address = true
    }
}

# tuple block

variable "server_config" {
  type = tuple([
    string,
    number,
    bool
  ])

  default = ["web-server", 20, true]
}

# output block

resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
}

output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

# locals block

locals {
  environment = "production"
}

resource "aws_instance" "web" {
  tags = {
    Environment = local.environment
  }
}

resource "aws_s3_bucket" "backup" {
  bucket = "my-backup-bucket"
  tags = {
    Environment = local.environment
  }
}

# resource block

resource "aws_instance" "web_server" {
  ami                    = "ami-xxxxxxxx"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-xxxxxxxx"

  tags = {
    Name        = "web-server"
    Environment = "dev"
  }
}

# module block 
# A module is a collection of Terraform configuration files used to create reusable infrastructure.
# Instead of writing the same resource code repeatedly, we can create a module and reuse it.

module "ec2_instance" {
  source        = "./modules/ec2"
  ami_id        = "ami-xxxxxxxx"
  instance_type = "t2.micro"
}

we cam call the same details in the main.tf file resource block 

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
}
