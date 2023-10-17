resource "aws_s3_bucket" "example" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name        = var.bucket_name
    Environment = terraform.workspace
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_policy = false
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.example.id
  policy = data.aws_iam_policy_document.allow_public_access_policy.json
}

data "aws_iam_policy_document" "allow_public_access_policy" {
  statement {
    sid = "PublicReadGetObject"
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    resources = [
      "${aws_s3_bucket.example.arn}/*"
    ]
  }
}



resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  index_document {
    suffix = var.index_file_sufix
  }

  error_document {
    key = var.error_file
  }
}