provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "myinstance" {
    ami = "ami-0b7ae50ea52e6be93"
    instance_type = "t3.micro"
    security_groups = []
}