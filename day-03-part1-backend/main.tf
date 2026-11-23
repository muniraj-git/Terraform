    resource "random_string" "instance_prefix" {
        length = 6
        upper = false
        special = false
        numeric = true
        lower = true
    }

    resource "aws_instance" "new_instance" {
        ami = "ami-0b7ae50ea52e6be93"
        instance_type = "t3.micro"
        tags = {
            Name = "${var.instance_name}-${random_string.instance_prefix.result}"
        }
    }