    resource "random_string" "bucket_prefix" {
        length = 6
        upper = false
        special = false
        numeric = true
        lower = true
    }

    resource "aws_s3_bucket" "mybucket" {
        bucket = "${var.bucket_name}-${random_string.bucket_prefix.result}"
    }