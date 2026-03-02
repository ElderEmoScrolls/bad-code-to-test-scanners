# Intentionally insecure Terraform configuration
# DO NOT USE IN PRODUCTION

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "2.0.0" # Old provider version
    }
  }
}

provider "aws" {
  region     = "us-east-1"

  # Hardcoded credentials (huge red flag)
  access_key = "AKIAFAKEKEY123456"
  secret_key = "fakeSecretKeyDontUseThis"
}

# Open security group to the world
resource "aws_security_group" "open_sg" {
  name        = "open-security-group"
  description = "Allow everything from everywhere"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Open to the world
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Public S3 bucket with no encryption
resource "aws_s3_bucket" "public_bucket" {
  bucket = "my-insecure-public-bucket-demo"
  acl    = "public-read"

  versioning {
    enabled = false
  }
}

# Explicitly disable public access block
resource "aws_s3_bucket_public_access_block" "disable_block" {
  bucket = aws_s3_bucket.public_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# EC2 instance with public IP and no IAM role
resource "aws_instance" "insecure_instance" {
  ami           = "ami-0c94855ba95c71c99" # Hardcoded AMI
  instance_type = "t2.micro"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.open_sg.id]

  # User data exposing credentials
  user_data = <<-EOF
              #!/bin/bash
              echo "DB_PASSWORD=SuperSecretPassword123" >> /etc/environment
              echo "AWS_SECRET_ACCESS_KEY=fakeSecretKeyDontUseThis"
              EOF

  tags = {
    Name = "insecure-instance"
  }
}

# RDS instance without encryption
resource "aws_db_instance" "insecure_db" {
  identifier        = "insecure-db"
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 20

  username = "admin"
  password = "admin123" # Hardcoded weak password

  skip_final_snapshot = true

  storage_encrypted = false
  publicly_accessible = true
}
