provider "aws" {
    region = "us-east-1"  
environment {
        AWS_ACCESS_KEY_ID = "AWS_ACCESS_KEY_ID"
        AWS_SECRET_ACCESS_KEY = "AWS_SECRET_ACCESS_KEY"
    }

resource "aws_instance" "foo" {
  ami           = "ami-05fa00d4c63e32376" # us-west-2
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
