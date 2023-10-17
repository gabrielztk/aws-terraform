variable "bucket_name" {
  type    = string
  default = "plain-website-bucket"
}

variable "website_folder" {
  type    = string
  default = "website"
}

variable "index_file_sufix" {
  type    = string
  default = "index.html"
}

variable "error_file" {
  type    = string
  default = "error/index.html"
}