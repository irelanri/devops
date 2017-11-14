variable "access_key" {}
variable "secret_key" {}
variable "rootuser" {}
variable "rootpasswd" {}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "eu-west-1"
}

# Create an AWS Virtual Private Cloud called my-vpc
resource "aws_vpc" "my-vpc" {

  # Classless Inter-Domain Routing table
  # This is IPv4 format
  # Determines the initial IP address (private) and number of further addresses i.e. mask
  cidr_block = "10.0.0.0/16"
}

# Put a Virtual Private Gateway onto the VPC
# This gateway is on the AWS end
resource "aws_vpn_gateway" "my-vpn_gateway" {
  vpc_id = "${aws_vpc.my-vpc.id}"
}

# Declare my Customer Gateway. This is about MY device.
# This is where it gets interesting
#
##resource "aws_customer_gateway" "customer_gateway" {
  ##bgp_asn    = 65000
  ##ip_address = "172.0.0.1"
  ##type       = "ipsec.1"
##}

##resource "aws_vpn_connection" "main" {
  ##vpn_gateway_id      = "${aws_vpn_gateway.vpn_gateway.id}"
  ##customer_gateway_id = "${aws_customer_gateway.customer_gateway.id}"
  ##type                = "ipsec.1"
  ##static_routes_only  = true
##}



# EC2 Instance
##resource "aws_instance" "terraform-example" {
  ##ami           = "ami-785db401"
  ##instance_type = "t2.micro"
##}

# Elastic IP
##resource "aws_eip" "ip" {
  ##instance = "${aws_instance.terraform-example.id}"
##}

# Create a database server
##resource "aws_db_instance" "default" {
  ##engine         = "mysql"
  ##engine_version = "5.6.35"
  ##instance_class = "db.t2.micro"
  ##name           = "initial_db"
  ##username       = "${var.rootuser}"
  ##password       = "${var.rootpasswd}"
  ##allocated_storage = 5 #Gb
  ##skip_final_snapshot = true

  # etc, etc; see aws_db_instance docs for more
##}

# Configure the MySQL provider based on the outcome of
# creating the aws_db_instance.
##provider "mysql" {
  ##endpoint = "${aws_db_instance.default.endpoint}"
  ##username = "${aws_db_instance.default.username}"
  ##password = "${aws_db_instance.default.password}"
##}
