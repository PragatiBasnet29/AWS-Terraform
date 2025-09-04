module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

module "cloudfront" {
  source              = "./modules/cloudfront"
  origin_domain_name  = module.s3.website_endpoint
  default_root_object = var.cloudfront_root_object
}
