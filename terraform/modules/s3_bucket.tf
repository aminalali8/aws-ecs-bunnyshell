resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_s3_bucket_object" "s3_bucket_object" {
  bucket = aws_s3_bucket.s3_bucket.id
  key    = "index.html"
  source = var.spa_folder_path
}
