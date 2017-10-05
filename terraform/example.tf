variable "access_key" {}
variable "secret_key" {}
variable "rootuser" {}
variable "rootpasswd" {}

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

# Create a database server
resource "aws_db_instance" "default" {
  engine         = "mysql"
  engine_version = "5.6.35"
  instance_class = "db.t2.micro"
  name           = "initial_db"
  username       = "${var.rootuser}"
  password       = "${var.rootpasswd}"
  allocated_storage = 5 #Gb

  # etc, etc; see aws_db_instance docs for more
}

# Configure the MySQL provider based on the outcome of
# creating the aws_db_instance.
provider "mysql" {
  endpoint = "${aws_db_instance.default.endpoint}"
  username = "${aws_db_instance.default.username}"
  password = "${aws_db_instance.default.password}"
}
