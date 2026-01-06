resource "aws_security_group" "web_sg" {
  name        = "task3-ubuntu-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = module.vpc.vpc_id # use your VPC resource name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "task3-ubuntu-sg" }
}

