resource "aws_security_group" "allow_8080" {
  name        = "allow-8080-tf"
  description = "Allow webserver inbound traffic to port 8080"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Webserver Ingress 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "allow_8080"
    Terraform = "true"
    Env       = var.env
  }
}
