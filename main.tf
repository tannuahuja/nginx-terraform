resource "aws_instance" "nginx_instance" {
  ami           = "ami-0e001c9271cf7f3b9"  
  instance_type = "t2.micro"
  tags = {
    Name = "nginx-task"
  }
}

resource "aws_eip" "nginx_IP" {
  instance = aws_instance.nginx_instance.id
  tags = {
    Name = "nginx-ip"
  }
}

resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Security group for Nginx Elastic IP"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
