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

}

    provider "aws" {
        region = "us-west-2"
    }

    resource "random_string" "bucket_prefix" {
        length = 6
        upper = false
        special = false
        numeric = true
        lower = true
    }

    resource "aws_s3_bucket" "mybucket" {
        bucket = "muni-${random_string.bucket_prefix.result}"
    }