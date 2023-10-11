output "bucket_regional_domain_name" {
  value = aws_s3_bucket.example.bucket_regional_domain_name
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.example.website_endpoint
}