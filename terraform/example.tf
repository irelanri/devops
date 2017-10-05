variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "eu-west-1"
}

# EC2 Instance
resource "aws_instance" "terraform-example" {
  ami           = "ami-785db401"
  instance_type = "t2.micro"
}

# Elastic IP
resource "aws_eip" "ip" {
  instance = "${aws_instance.terraform-example.id}"
}
