#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-ddd57685
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-crow
#

variable "num_webs"{
  default = "1"
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type    = "string"
  default = "us-west-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}" # "AKIAIGSRLOEJ57P46ZZA"
  secret_key = "${var.aws_secret_key}" # "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"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-30217250"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-ddd57685"
  vpc_security_group_ids = ["sg-29ef374e"]
  count                  = "${var.num_webs}"

  tags {
    Identity  = "autodesk-crow"
    Developer = "satyam"
    Training  = "terraform"
    Office    = "Autodesk"
    Name = "Web ${count.index+1}/${var.num_webs}"
  }
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}
