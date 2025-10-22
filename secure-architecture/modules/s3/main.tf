resource "aws_s3_bucket" "app_data" {
  bucket = var.bucket_name

  tags = {
    Name = "secure-app-data"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.app_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
