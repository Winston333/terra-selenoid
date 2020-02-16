provider "aws" {
  region     = "eu-central-1"
}

resource "aws_instance" "ubuntu_selenoid" {
  ami                    = "ami-0b418580298265d5c"
  instance_type          = "t2.micro"
  key_name               = "Selenoid4"
  vpc_security_group_ids = [aws_security_group.selenoid_sg.id]
  user_data              = file("selenoid_install.sh")
}

output "aws_instance_public_ip" {
  value = aws_instance.ubuntu_selenoid.public_ip
}

resource "aws_security_group" "selenoid_sg" {
  name        = "Selenoid security group"
  description = "Selenoid security group"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4444
    to_port     = 4444
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
