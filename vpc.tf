# Configure the AWS Provider
provider "aws" {
        access_key =    "AKIAYDH5SEQT2NR3YHNP"
        secret_key =    "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" 
        region =        "us-east-1"
}

# creating vpc, name, CIDR block & tags.
resource "aws_vpc" "my_vpc" {
        cidr_block =            "10.0.0.0/20"
        instance_tenancy =      "default"
        enable_dns_support =    "true"
        enable_dns_hostnames =  "true"

        tags = {
                Name = "my_vpc"
  }
}

# creating public subnet, interpolating with vpc, CIDR block, tags, availabilty zone
resource "aws_subnet" "public_subnet" {
        vpc_id     =                    aws_vpc.my_vpc.id
        cidr_block =                    "10.0.0.0/21"
        map_public_ip_on_launch =       "true"
        availability_zone =             "us-east-1a"
        tags = {
                Name = "public_subnet"
  }
}

# creating private subnet, interpolating with vpc, CIDR block, tags, availabilty zone
resource "aws_subnet" "private_subnet" {
        vpc_id     =                    aws_vpc.my_vpc.id
        cidr_block =                    "10.0.8.0/21"
        map_public_ip_on_launch =       "false"
        availability_zone =             "us-east-1a"
        tags = {
                Name = "private_subnet"
  }
}

# Provides a resource to create a VPC Internet Gateway.
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "IGW"
  }
}

# creating route table for internet gayeway & public subnet
resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "public-RT"
  }
}

# creating route table for private subnet
resource "aws_route_table" "private-RT" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "private-RT"
  }
}

# public route table association with public subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public-RT.id
}

# private route table association with private subnet
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private-RT.id
}

# aws instance creation in public subnet
resource "aws_instance" "instance1" {
    ami = "ami-0574da719dca65348"
    count=1
    instance_type = "t2.micro"
    subnet_id     = "${aws_subnet.public_subnet.id}"
    key_name = "anup1"

        tags = {
            Name = "instance-1"
        }
}
