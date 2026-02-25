
# RDS DB Subnet Group (required for RDS in a VPC)
resource "aws_db_subnet_group" "default" {
  name       = "${var.environment}-rds-subnet-group"
  subnet_ids = module.vpc.private_subnets # Place in private subnets

  tags = {
    Terraform = "true"
  }
}

# RDS instance in the private subnet
resource "aws_db_instance" "private_rds" {
  allocated_storage    = 20
  db_name              = var.db_name
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.rds_instance_class
  identifier           = "${var.environment}-rds-instance"
  username             = var.db_username
  password             = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.default.name
  skip_final_snapshot  = true # Set to false for production
  depends_on            = [aws_db_subnet_group.default]
}