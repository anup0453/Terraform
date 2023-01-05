# provider block is optional below. Without provider block also script will execute.

provider "aws" {
        region = var.region
        access_key = var.access_key
        secret_key = var.secret_key
}

module "ec2" {
        source = "./ec2"
}

module "vpc" {
        source = "/home/ubuntu/Terraform/module_project/vpc"
}
