terraform{
    required_version = "~> 1.4"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 6.0"
        }

         random = {
        source = "hashicorp/random"
        version = "~> 3.0"
         }
    }
    backend "s3" {
        bucket = "muni-project-p4rx2w"
        key = "prod/terraform.tfstate"
        region = "us-west-2"
    }
}

provider "aws" {
        region = "us-west-2"
    }