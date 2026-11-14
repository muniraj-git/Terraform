provider "aws" {
    region = "us-west-2"

}

resource "aws_instance" "ec2" {

    ami = "ami-0346507e743a5ffc6"
    instance_type = "t3.large"
    security_groups = ["class"]
   
    root_block_device {
        volume_size = 30
        volume_type = "gp3"
        delete_on_termination = true
    }

    key_name = "dev"

    user_data = file("jenkins_server.sh")
    
    tags = {
        Name = "Admin-server"
    }
}

output "PublicIP" {
    value = aws_instance.ec2.public_ip
}