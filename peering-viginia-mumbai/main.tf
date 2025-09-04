module "virginia_vpc" {
  source    = "./modules/vpc"
  providers = { aws = aws.virginia }
  cidr_block = var.virginia_cidr_block
  vpc_name  = "virginia-vpc"
}

module "mumbai_vpc" {
  source    = "./modules/vpc"
  providers = { aws = aws.mumbai }
  cidr_block = var.mumbai_cidr_block
  vpc_name  = "mumbai-vpc"
}

module "peer" {
  source = "./modules/vpc_peering"
  providers = {
    aws.requester = aws.virginia
    aws.accepter  = aws.mumbai
  }
  requester_vpc_id  = module.virginia_vpc.vpc_id
  accepter_vpc_id   = module.mumbai_vpc.vpc_id
  accepter_region   = var.mumbai_region
  auto_accept       = true
  tags = {
    Name = "virginia-mumbai-peering"
  }
}
