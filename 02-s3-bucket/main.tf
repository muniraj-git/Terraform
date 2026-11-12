provider "aws" {
    region = "us-west-2"
    access_key = ""
    secret_key = ""
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "terraform-muni-bucket"
}
