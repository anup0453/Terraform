provider "aws" {
        access_key = "AKIAYDH5SEQT2NR3YHNP"
        secret_key = "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"
        region = "us-east-1"
}

resource "aws_instance" "instance1" {
    ami = "ami-0574da719dca65348"
    count=1
    instance_type = "t2.micro"
    key_name = "anup1"
    security_groups = ["ec2-sg"]

        tags = {
            Name = "I1"
        }
}

resource "aws_security_group" "ec2-sg" {
  name = "ec2-sg"

  ingress {
     from_port = 22
         to_port = 22
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
     from_port = 80
         to_port = 80
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
     from_port = 0
         to_port = 0
         protocol = "-1"
         cidr_blocks = ["0.0.0.0/0"]
  }
}
