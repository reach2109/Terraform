provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "terratest" {
ami                    = "ami-0ab0629dba5ae551d"
instance_type          = "t2.micro"
vpc_security_group_ids = [aws_security_group.instance.id]

user_data = <<-EOF
            #!/bin/bash
            echo "Hello World" > index.html
            nohup busybox httpd -f -p 8080 &
            EOF
tags = {
Name   = "Terraform-Example"
Branch = "Learning"
 }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port = "8080"
    to_port   = "8080"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
} 
  
