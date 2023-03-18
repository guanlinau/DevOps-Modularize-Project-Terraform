// 2) Create a subnet for that created vpc
resource "aws_subnet" "myapp_subnet-1" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name: "${var.env_profix}-subnet-1"
  }
}

// 3) Create a internet gateway for that created vpc

resource "aws_internet_gateway" "myapp_igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.env_profix}-igw"
  }
}

// 4-1) Create a new route table for external request traffic be access to that created vpc
# resource "aws_route_table" "myapp_route_table" {
#   vpc_id = var.vpc_id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.myapp_igw.id
#   }
#   tags = {
#     Name : "${var.env_profix}-route-table"
#   }
  
# }

// 5) Accociate subnet with the new route table
# resource "aws_route_table_association" "association_rtb_subnet" {
#   subnet_id = aws_subnet.myapp_subnet-1.id
#   route_table_id = aws_route_table.myapp_route_table.id 
# }


// 4-2) Update the main/default route table for external request traffic be access to that created vpc instead
// of create a new one
resource "aws_default_route_table" "main_route_table" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp_igw.id
  }
  tags = {
    Name = "${var.env_profix}-main-route-table"
  }
  
}

