provider "aws" {
  region = "eu-west-2"
}

resource "aws_security_group" "stock_quote_sg" {
  name        = "stock-quote-sg"
  description = "Security group for the stock quote EC2 instance"
  vpc_id      = var.vpc_id

  # Ingress rules for allowed ports
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH - Allow from anywhere (consider restricting)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # HTTP
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # HTTPS
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SonarQube
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "stock_quote_ec2" {
  ami                    = var.aws_ami
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.stock_quote_sg.id]
  key_name               = var.key_name

  root_block_device {
    volume_size           = 15
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "python-stock-quote"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io
              systemctl start docker
              systemctl enable docker
              EOF
}

# Allocate Elastic IP
resource "aws_eip" "stock_quote_eip" {
  domain = "vpc"
}

# Associate Elastic IP with EC2
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.stock_quote_ec2.id
  allocation_id = aws_eip.stock_quote_eip.id
  depends_on    = [aws_instance.stock_quote_ec2]
}
