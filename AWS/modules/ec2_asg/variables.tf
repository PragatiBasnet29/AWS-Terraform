variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "alb_sg_id" {
  description = "ALB Security Group ID"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
