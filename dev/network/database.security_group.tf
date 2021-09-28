resource "aws_security_group" "allow_5432" {
  name        = "allow-5432-tf"
  description = "Allow postgres database inbound traffic to port 5432"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Postgres Ingress 5432"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "allow_5432"
    Terraform = "true"
  }
}
