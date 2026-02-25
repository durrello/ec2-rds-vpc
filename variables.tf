variable "instance_name" {
  type        = string
  description = "The name of the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "The type of the EC2 instance"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID for the EC2 instance"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "The availability zones for the VPC"
}

variable "private_subnets" {
  type        = list(string)
  description = "The CIDR blocks for the private subnets"
}

variable "public_subnets" {
  type        = list(string)
  description = "The CIDR blocks for the public subnets"
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = "dev"
}

variable "public_subnets_cidr" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "private_subnets_cidr" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "db_name" {
  description = "Name for the RDS database"
  type        = string
  default     = "mydb"
}

variable "db_engine" {
  description = "RDS database engine"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "RDS database engine version"
  type        = string
  default     = "8.0.35"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  # !! Use a more secure method (e.g., Terraform vars file, AWS Secrets Manager) for production !!
  default     = "ChangeMe123!" 
}

variable "db_allocated_storage" {
  description = "The amount of storage (in GB) to allocate for the RDS instance"
  type        = number
}

variable "db_instance_class" {
  description = "The instance type for the RDS database (e.g., db.t3.micro)"
  type        = string
}

variable "db_parameter_group_name" {
  description = "The name of the DB parameter group to associate with this instance"
  type        = string
  default     = "default.mysql8.0" # Adjust based on your engine
}

variable "enable_db_manage_master_user_password" {
  description = "Whether to allow AWS to manage the master user password via Secrets Manager"
  type        = bool
  default     = true
}
