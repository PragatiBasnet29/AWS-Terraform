variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "cloudfront_root_object" {
  description = "Default root object for CloudFront"
  type        = string
  default     = "index.html"
}
