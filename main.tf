#############################################
#####                                   #####
#####---------FINAL-PROJECT-------------#####
#####                                   #####
#############################################
# Amazon Web Services (AWS)---111
provider "aws" {
  region = "us-east-1"
}

##Create es2 instance
resource "aws_instance" "wordpress" {
  ami                    = "ami-006dcf34c09e50022"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_tcp.id]
  user_data              = file("init.sh")
  tags = {
    Name = "Wordpress"
    Owner = "Alex"
  }
}
###Create security_group
resource "aws_security_group" "allow_tcp" {
  name        = "allow_tcp"
  description = "Allow TCP inbound traffic"

  #-------------------------HTTPS-Server-Enable-------------------------------
  dynamic "ingress" {
    for_each = [ "22", "80", "443" ]
    content {
      from_port = ingress.value
      to_port   = ingress.value
      description = "tcp_port"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
    }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tcp"
  }
}
