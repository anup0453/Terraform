provider "aws" {
        access_key = "AKIAYDH5SEQT555V3UTV"
        secret_key = "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"
        region =        "us-east-1"
}

locals {
        key_pair = "anup1"
}

resource "aws_instance" "main" {
        ami           = "ami-06878d265978313ca"
        instance_type = "t2.micro"
        key_name = "${local.key_pair}"

  tags = {
    Name = "ubuntu"
  }
}

# output variable for printing the parameters of instance .public_ip used to print public ip. 

output "all_information" {
        value = aws_instance.main.public_ip
        sensitive = "true"
}
