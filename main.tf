provider "aws" {
  region  = "eu-central-1"
  profile = "cantrill-lab"
}
resource "aws_s3_bucket" "logs" {
  bucket = "hendrik-security-baseline-logs-2026"
  tags = {
    Name        = "hendrik-security-baseline-logs-2026"
    Environment = "lernen"
  }
}
resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
