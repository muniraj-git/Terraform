resource "random_string" "bucket_prefix" {
    length = 8
    upper = false
    special = false
    lower = true
    numeric = true
}

resource "aws_s3_bucket" "static_webhosting" {
    bucket = "${var.bucket_name}-${random_string.bucket_prefix.result}"
}

resource "aws_s3_bucket_public_access_block" "webhosting" {
    bucket = aws_s3_bucket.static_webhosting.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "static_webhosting_public_read" {
    bucket = aws_s3_bucket.static_webhosting.id

    depends_on = [
        aws_s3_bucket_public_access_block.webhosting
    ]

    policy = jsonencode ({
        Version = "2012-10-17"
        Statement = [
            {
              Sid = "PublicReadGetObject"
              Effect = "Allow"
              Principal = "*"
              Action = "s3:GetObject"
              Resource = "${aws_s3_bucket.static_webhosting.arn}/*"
            }
        ]
    })
}

resource "aws_s3_bucket_website_configuration" "static_website_configuration" {
    bucket = aws_s3_bucket.static_webhosting.id
    
    index_document {
        suffix = "index.html"
    }
}

resource "aws_s3_object" "index"{
    bucket = aws_s3_bucket.static_webhosting.id
    key = "index.html"
    source = "code/index.html"
    etag = filemd5("code/index.html")
    content_type = "text/html"
}