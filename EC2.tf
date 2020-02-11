provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0ddb57c0f6c4ff075"
  instance_type = "t2.micro"
}
