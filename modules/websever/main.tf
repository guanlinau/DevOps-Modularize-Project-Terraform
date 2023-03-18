// 6) Create security group based on default security group
resource "aws_default_security_group" "myapp_default_security_group" {
  vpc_id = var.vpc_id
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ var.my_ip_address]
  }
  ingress {
    from_port = 8080
    to_port = 8080  
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags ={
    Name = "${var.env_profix}-myapp_new_security_group"
  }
}

// 7) Create ec2 instance inside that created vpc

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [ var.aws_ami_image ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
}



resource "aws_key_pair" "ssh-key" {
  key_name = "server-key"
  public_key = file(var.public_key_location)
  
}

resource "aws_instance" "myapp_server" {
  ami =data.aws_ami.latest-amazon-linux-image.id

  instance_type = var.instance_type

  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_default_security_group.myapp_default_security_group.id]
  availability_zone = var.availability_zone

  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name

  user_data = <<EOF
                   #!/bin/bash
                    mkdir myapp
                    sudo yum update -y && sudo yum install -y docker
                    sudo systemctl start docker 
                    sudo usermod -aG docker ec2-user
                    docker run -p 8080:80 nginx
              EOF
  
  // below is for provisioner
#   connection {
#     type="ssh"
#     host = self.public_ip
#     user = "ec2-user"
#     private_key = file(var.private_key_location)
#   }

#   provisioner "file" {
#     source = "entry-script.sh"
#     destination = "/home/ec2-user/entry-script.sh"
#   }
# provisioner "remote-exec" {
#     inline =[
#       "ls",
#       "sudo yum update -y && sudo yum install -y docker",
#       "sudo systemctl start docker ",
#       "sudo usermod -aG docker ec2-user",
      
#       "docker run -p 8080:80 nginx",
#     ]
#   }

#   provisioner "local-exec" {
#     command = "echo ${self.public_ip} " && "echo ${self.public_ip} > output.txt"
    
#   }
  tags = {
     Name = "${var.env_profix}-server"
  }
}


