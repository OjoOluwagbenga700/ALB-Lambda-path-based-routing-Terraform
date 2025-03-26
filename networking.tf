module "networking" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name           = var.vpc_name
  cidr           = var.vpc_cidr
  azs            = var.azs
  public_subnets = var.public_subnets
  #private_subnets      = var.private_subnets
  enable_nat_gateway   = false
  enable_dns_hostnames = true
}


resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Security group for ALB"
  vpc_id      = module.networking.vpc_id

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
}
