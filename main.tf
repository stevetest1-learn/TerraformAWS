#provider block
provider "aws" {
    profile = "default"
    region = "us-east-1"
}

##VPC
resource "aws_vpc" "my_test_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = var.vpc_name
    }
}

##subnet
resource "aws_subnet" "my_test_subnet" {
    vpc_id = aws_vpc.my_test_vpc.id
    cidr_block = var.subnet_cidr

    tags = {
        Name = var.subnet_name
    }
}

###Create the route to the internet
resource "aws_internet_gateway" "my_ig" {
    vpc_id = aws_vpc.my_test_vpc.id

    tags = {
        Name = var.igw_name
    }
}

#Route Table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.my_test_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_ig.id

    }
    tags = {
        Name = var.igw_name
    }
} 

##associates route table with submet
resource "aws_route_table_association" "public_1_rt_assoc" {
    subnet_id = aws_subnet.my_test_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

#creates new security group open to HTTP trafic
resource "aws_security_group" "app_sg" {
    name = "HTTP"
    vpc_id = aws_vpc.my_test_vpc.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]

    }
    
}


#instance EC2 block
resource "aws_instance" "app_server" {
  ami           = var.ec2_ami # us-east-1
  instance_type = "t2.micro"

   
   subnet_id = aws_subnet.my_test_subnet.id
   vpc_security_group_ids = [aws_security_group.app_sg.id]
   associate_public_ip_address = true

    tags = {
        "Name" : var.ec2_name
} 

}