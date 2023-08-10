# Criação do S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "your-observability-bucket-name"
}