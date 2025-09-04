provider "aws" {
  alias  = "virginia"
  region = var.virginia_region
}

provider "aws" {
  alias  = "mumbai"
  region = var.mumbai_region
} 