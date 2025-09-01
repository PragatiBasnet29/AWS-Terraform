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
  region = "ap-south-1"
}

module "vpc" {
  source      = "../../modules/vpc"
  region      = "ap-south-1"
  environment = "stage"
}

module "alb" {
  source           = "../../modules/alb"
  region           = "ap-south-1"
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  environment      = "stage"
}

module "ec2_asg" {
  source           = "../../modules/ec2_asg"
  region           = "ap-south-1"
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  environment      = "stage"
  alb_sg_id        = module.alb.alb_sg_id
}
