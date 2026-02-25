# EC2 instance in the public subnet
resource "aws_instance" "public_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnets[0] 
  security_groups = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "${var.environment}-public-ec2"
  }
}