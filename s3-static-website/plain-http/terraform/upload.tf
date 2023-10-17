module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "${path.root}/../${var.website_folder}"
}

resource "aws_s3_object" "object" {
  for_each = module.template_files.files

  bucket = aws_s3_bucket.example.bucket
  key    = each.key
  source = each.value.source_path
  etag   = each.value.digests.md5
}