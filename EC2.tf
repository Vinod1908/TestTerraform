provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0732ea48f2834099b"
  instance_type = "t2.micro"
}