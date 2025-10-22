resource "aws_s3_bucket" "tf_state" {
  bucket = "terraform-state-bhanudas"

  tags = {
    Name    = "terraform-state"
    Owner   = "Bhanudas"
    Purpose = "Remote state for secure and vulnerable environments"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"  # ✅ Protects against accidental overwrites
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"  # ✅ Enable SSE-S3 encryption
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true   # ✅ Block public ACLs
  block_public_policy     = true   # ✅ Block public policies
  ignore_public_acls      = true
  restrict_public_buckets = true
}
