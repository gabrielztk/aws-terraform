resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Name        = "Static-Website"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.example.id
  acl    = "public-read"
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
      "arn:aws:s3:::${var.bucket_name}/*",
      "arn:aws:s3:::${var.bucket_name}"
    ]
  }
}

resource "aws_s3_object" "example-index" {
  depends_on = [
    aws_s3_bucket_policy.allow_public_access,
  ]

  bucket       = aws_s3_bucket.example.id
  key          = var.index_file
  source       = "${var.website_root_folder}/${var.index_file}"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "about-index" {
  depends_on = [
    aws_s3_bucket_policy.allow_public_access,
  ]

  bucket       = aws_s3_bucket.example.id
  key          = var.about_file
  source       = "${var.website_root_folder}/${var.about_file}"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "example-error" {
  depends_on = [
    aws_s3_bucket_policy.allow_public_access,
  ]

  bucket       = aws_s3_bucket.example.id
  key          = var.error_file
  source       = "${var.website_root_folder}/${var.error_file}"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.id

  depends_on = [
    aws_s3_object.example-index,
    aws_s3_object.example-error,

  ]

  index_document {
    suffix = var.index_file
  }

  error_document {
    key = var.error_file
  }
}