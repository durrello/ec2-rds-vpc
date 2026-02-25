terraform {
  backend "s3" {
    bucket = "primus-backend-bucket-terraform"
    key    = "vpc-module-ec2/terraform.tfstate"
    region = "us-east-1"
  }
}
