# Define the AWS provider
provider "aws" {
  region = "us-east-2" # Change to your preferred region
}

# Create an S3 bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = "terraform-demo-bucket00456" # Replace with a unique bucket name

  # Enable versioning for the bucket
  versioning {
    enabled = true
  }

  # Enable server-side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256" # Default encryption algorithm
      }
    }
  }

}

# Output the bucket name
output "bucket_name" {
  value       = aws_s3_bucket.example_bucket.bucket
  description = "terraform_demo_bucket"
}
