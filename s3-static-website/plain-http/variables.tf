variable "bucket_name" {
  type    = string
  default = "plain-website-bucket-1998"
}

variable "website_root_folder" {
  type = string
  default = "website"
}

variable "index_file" {
  type    = string
  default = "index.html"
}

variable "error_file" {
  type    = string
  default = "error.html"
}

variable "about_file" {
  type    = string
  default = "about/index.html"
}