variable "bucket_name" {
  type    = string
  default = "cloudfront-staticwebsite-bucket-0909"
}

variable "website_folder" {
  type    = string
  default = "static-website-example"
}

variable "default_root_object" {
  type    = string
  default = "index.html"
}