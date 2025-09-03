variable "virginia_cidr_block" {
  type        = string
  description = "CIDR block for the Virginia VPC"
}

variable "mumbai_cidr_block" {
  type        = string
  description = "CIDR block for the Mumbai VPC"
}

variable "virginia_region" {
  type        = string
  description = "AWS region for the Virginia provider"
  default     = "us-east-1"
}

variable "mumbai_region" {
  type        = string
  description = "AWS region for the Mumbai provider"
  default     = "ap-south-1"
} 