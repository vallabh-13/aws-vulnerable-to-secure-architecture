resource "aws_s3_bucket" "vulnerable_bucket" {
  bucket = "vulnerable-bucket-${random_id.suffix.hex}"

  tags = {
    Name = "vulnerable-s3"
  }
}

resource "aws_s3_bucket_public_access_block" "vulnerable_block" {
  bucket = aws_s3_bucket.vulnerable_bucket.id

  block_public_acls       = false  # 
  block_public_policy     = false  # 
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "vulnerable_policy" {
  bucket = aws_s3_bucket.vulnerable_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.vulnerable_bucket.arn}/*"
      }
    ]
  })
}

resource "random_id" "suffix" {
  byte_length = 4
}
