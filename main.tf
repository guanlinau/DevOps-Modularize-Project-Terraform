# Configure the AWS Provider
//Define the provider
provider "aws" {
  region = "ap-southeast-1"
}


// 1) Create a vpc 
resource "aws_vpc" "myapp_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_profix}-vpc"
  }
}

// Create subnet 
module "myapp-subnet" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.myapp_vpc.id
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone=var.availability_zone
  env_profix=var.env_profix
  default_route_table_id = aws_vpc.myapp_vpc.default_route_table_id
}

// Create instance

module "myapp-instance" {
  source = "./modules/websever"
  vpc_id = aws_vpc.myapp_vpc.id
  my_ip_address = var.my_ip_address
  env_profix = var.env_profix
  aws_ami_image = var.aws_ami_image
  public_key_location = var.public_key_location
  instance_type = var.instance_type
  subnet_id = module.myapp-subnet.subnet.id
  availability_zone = var.availability_zone
}