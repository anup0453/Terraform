resource "aws_instance" "instance_1" {
        ami = "${lookup(var.ami_id,var.region)}"
        instance_type = var.instance_type
        key_name = var.ec2_keypair
        count = var.ec2_count
}
