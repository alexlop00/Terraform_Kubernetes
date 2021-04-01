#Creator: Alexander Lopez

#Declare AWS
provider "aws" {
	profile = "default"
	region = "us-east-2"
}
#Warning: Adjust the region according to your configuration.

#Provision VPC
resource "aws_vpc" "kube_vpc" {
	cidr_block		= "192.168.5.0/24"
	enable_dns_support	= true
	enable_dns_hostnames	= true
	tags = 			{
		Name		= "kube_vpc"
	}
}

#Provision Subnet1
resource "aws_subnet" "kube_subnet1" {
	availability_zone	= "us-east-2a"
	vpc_id			= aws_vpc.kube_vpc.id
	cidr_block		= "192.168.5.0/26"
	tags =			{
		Name		= "kube_subnet1"
	}
}
#Warning: Adjust the availability zone according to your configuration.

#Provision Subnet2
resource "aws_subnet" "kube_subnet2" {
        availability_zone       = "us-east-2b"
        vpc_id                  = aws_vpc.kube_vpc.id
        cidr_block              = "192.168.5.64/26"
        tags =                  {
                Name            = "kube_subnet2"
        }
}
#Warning: Adjust the availability zone according to your configuration.

#Provision Subnet3
resource "aws_subnet" "kube_subnet3" {
        availability_zone       = "us-east-2c"
        vpc_id                  = aws_vpc.kube_vpc.id
        cidr_block              = "192.168.5.128/26"
        tags =                  {
                Name            = "kube_subnet3"
        }
}
#Warning: Adjust the availability zone according to your configuration.

#Provision Internet Gateway
resource "aws_internet_gateway" "kube_ig" {
	vpc_id			= aws_vpc.kube_vpc.id
	tags =	{
		Name		= "kube_ig"
	}
}

#Provision Route Table and Routes
resource "aws_route_table" "kube_routetable" {
	vpc_id			= aws_vpc.kube_vpc.id
	route {
		cidr_block	= "0.0.0.0/0"
		gateway_id	= aws_internet_gateway.kube_ig.id
	}
	tags =			{
		Name		= "kube_routetable"
	}
}
#Warning: Allows Open Access within the VPC

#Associate Route Table to Subnets
resource "aws_route_table_association" "kube_associate1" {
	subnet_id		= aws_subnet.kube_subnet1.id
	route_table_id		= aws_route_table.kube_routetable.id
}
resource "aws_route_table_association" "kube_associate2" {
	subnet_id		= aws_subnet.kube_subnet2.id
	route_table_id		= aws_route_table.kube_routetable.id
}
resource "aws_route_table_association" "kube_associate3" {
	subnet_id		= aws_subnet.kube_subnet3.id
	route_table_id		= aws_route_table.kube_routetable.id
}

#Provision Security Group
#Allows SSH Access to EC2 Master Instance
resource "aws_security_group" "kube_secgroup" {
	description		= "kube secgroup: SSH to Master Instance"
	vpc_id 			= aws_vpc.kube_vpc.id
	ingress {
		description 	= "SSH into Instance"
		from_port	= 22
		to_port		= 22
		protocol	= "tcp"
		cidr_blocks	= ["0.0.0.0/0"]
	}
	egress {
		from_port	= 0
		to_port		= 0
		protocol	= "-1"
		cidr_blocks	= ["0.0.0.0/0"]
	}
	tags = {	
		Name		= "kube_secgroup"
	}
}

#Provision EC2 Instance
#Image:Ubuntu20
resource "aws_instance" "kube_controller_ec2" {
	ami			= "ami-08962a4068733a2b6"
	associate_public_ip_address = true
	instance_type		= "t2.micro"
	security_groups		= [aws_security_group.kube_secgroup.id]
	subnet_id		= aws_subnet.kube_subnet1.id
	tags			= {
		Name		= "kube_controller"
	}
}

