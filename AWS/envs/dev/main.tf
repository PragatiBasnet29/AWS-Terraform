terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source      = "../../modules/vpc"
  region      = "us-east-1"
  environment = "dev"
}

module "alb" {
  source           = "../../modules/alb"
  region           = "us-east-1"
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  environment      = "dev"
}

module "ec2_asg" {
  source           = "../../modules/ec2_asg"
  region           = "us-east-1"
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  environment      = "dev"
  alb_sg_id        = module.alb.alb_sg_id
}
