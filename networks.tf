# Use the VPC module to create a VPC, public, and private subnets
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${var.environment}-vpc"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway = true
  enable_dns_hostnames = true
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

# Security group for the EC2 instance (public)
resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2_sg"
  vpc_id      = module.vpc.vpc_id

  # Allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access (if running a web server)
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

# Security group for the RDS instance (private)
resource "aws_security_group" "rds_sg" {
  name_prefix = "rds_sg"
  vpc_id      = module.vpc.vpc_id

  # Allow MySQL/Aurora access from the EC2 security group
  ingress {
    from_port   = 3306 # Default MySQL port
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

