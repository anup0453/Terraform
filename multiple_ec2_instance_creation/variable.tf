variable "access_key" {}
variable "secret_key" {}
variable "region" {
        default = "us-east-1"
}
variable "ami_id" {
        type = map
        default = {

                us-east-1 = "ami-0574da719dca65348"
                us-east-2 = "ami-0283a57753b18025b"
                us-west-1 = "ami-0a1a70369f0fce06a"
        }
}

variable "instance_type" {
        default = "t2.micro"
}

variable "ec2_keypair" {
        default = "anup1"
}

variable "ec2_count" {
        type = number
        default = "3"
}
