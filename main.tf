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