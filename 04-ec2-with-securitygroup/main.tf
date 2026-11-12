provider "aws" {
    region = "us-west-2"
}


resource "aws_security_group" "webtraffic" {
    name = "allow"
#inbound rule
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

#outbound rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "new_instance" {
    ami = "ami-0b7ae50ea52e6be93"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.webtraffic.id]

    tags = {
        Name = "myinstance"
    }

}