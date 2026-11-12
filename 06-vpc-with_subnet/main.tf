provider "aws" {
    region = "us-west-2"
}

resource "aws_vpc" "muni_vpc" {

    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "muni_vpc"
    }
}

#subnet is created with a vpc hence we will use the ID we have given above to create subnet

resource "aws_subnet" "muni_subnet" {

    vpc_id = aws_vpc.muni_vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "muni_sub"
    }
}

import {
    to = aws_vpc.muni_vpc
    id = "vpc-0932213485fe2461b"
}

import {
    to = aws_subnet.muni_subnet
    id = "subnet-0258a854d496078b9"
}