output "bucket_id" {
  value = module.s3.bucket_id
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}

output "cloudfront_domain" {
  value = module.cloudfront.cloudfront_domain_name
}
