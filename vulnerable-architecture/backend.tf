terraform {
  backend "s3" {
    bucket = "terraform-state-bhanudas"
    key    = "vulnerable/terraform.tfstate"
    region = "us-east-2"
    encrypt = true  # 
  }
}
